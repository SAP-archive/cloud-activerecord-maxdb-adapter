require 'arel/visitors/maxdb'

module ::ArJdbc

  module MaxDB
    # This defines an Arel visitor for our adapter. See https://github.com/jruby/activerecord-jdbc-adapter/issues/137
	def self.arel2_visitors(config)
	  { 'jdbc' => ::Arel::Visitors::MaxDB }
	end
	
	# Along with each newly created table, we need a corresponding sequence for primary key generation.
	def create_table(name, options = {})
	  super(name, options)
	  execute("CREATE SEQUENCE #{default_sequence_name(name)} START WITH 1 INCREMENT BY 1")
    end
	
	# ... and we need to take care for the clean up.
	def drop_table(name)
	  super(name)
	  execute("DROP SEQUENCE #{default_sequence_name(name)}")
	end
	
	def default_sequence_name(table_name, primary_key = nil) # :nodoc:
	  "#{table_name}_seq"
    end
	
	# Get the next value from the sequence. See http://maxdb.sap.com/doc/7_8/44/e15c6499fc03fde10000000a1553f6/content.htm
	def next_sequence_value(sequence_name)
	  execute("SELECT #{sequence_name}.NEXTVAL id FROM dual").first['id'].to_i
	end
	
	def modify_types(tp)
	  tp[:primary_key] = "INTEGER NOT NULL DEFAULT SERIAL PRIMARY KEY"
	  tp[:string] = { :name => 'VARCHAR', :limit => 255 }
	  tp[:integer] = { :name => 'INTEGER', :limit => nil }
	  tp[:boolean]     = { :name => 'BOOLEAN' }
	  tp
	end
	
	def add_column_options!(sql, options)
	  options.delete(:default) if options.has_key?(:default) && options[:default].nil?
	  sql << " DEFAULT #{quote(options.delete(:default))}" if options.has_key?(:default)
	  super
	end
	
	def change_column_default(table_name, column_name, default) #:nodoc:
	  column = column_for(table_name, column_name)
	  change_column table_name, column_name, column.sql_type, :default => default
	end
	
	# Handle correctly some boolean literals.
	def quote(value, column = nil)
	  return value.quoted_id if value.respond_to?(:quoted_id)
	  
	  if column && column.respond_to?(:primary) && column.primary && column.klass != String
	    return value.to_i.to_s
	  end
	  
	  case value
	    when TrueClass then 'true'
		when FalseClass then 'false'
		else super
	  end
	end
	
	# The default generated index names can be too long for MaxDB, so we override the add_index method
	# and use the idx_tableName_columnName pattern for naming the indexes. This worked for our use case.
	
	def add_index(table_name, column_name, options = {})
	  statement = "CREATE"
	  statement << " UNIQUE " if options[:unique]
	  statement << " INDEX idx_" + "#{table_name}" + "_" + "#{column_name}"
	  statement << " ON #{table_name}(#{column_name})"
	  execute statement
	end
	
	# We got a 'non existing method' error, so we had to implement this method as well. Basically, it introduces a NULL
    # or a NOT NULL constraint on a given table and column, depending on the value of the boolean 'null' parameter
    
    def change_column_null(table_name, column_name, null)
      if null
        execute "ALTER TABLE #{table_name} MODIFY (#{column_name} NULL)"
      else
        execute "ALTER TABLE #{table_name} MODIFY (#{column_name} NOT NULL)"
      end
    end
	
	# We use eagerly prefetching of primary keys in order to get ActiveRecord synced with the auto generated primary key
	# in the database.
	def prefetch_primary_key?(table_name = nil)
	  true
	end

    def adapter_name #:nodoc:
      'maxdb'
    end

  end
  
end

module ActiveRecord
  module ConnectionAdapters
  
    # Metadata model for a MaxDB column.
    class MaxDBColumn < JdbcColumn

	  # The default value of a primary key column is a very strange string, which eventually becomes a zero - 0 -
	  # for ActiveRecord. But we have to use 'nil' so that ActiveRecord fetches the newly generated pk value when
      # an INSERT statement has been executed.
      def default_value(val)
        if String === val && val.include?("DEFAULT SERIAL")
          nil
        else
          val
        end
      end
    end

    class MaxDBSQLAdapter < JdbcAdapter
      include ArJdbc::MaxDB
	  
      def jdbc_column_class
        ActiveRecord::ConnectionAdapters::MaxDBColumn
      end
	  
    end

  end
end