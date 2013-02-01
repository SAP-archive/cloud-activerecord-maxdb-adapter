# ActiveRecord JDBC adapter for SAP MaxDB database

This is an ActiveRecord JDBC adapter for the [SAP MaxDB database](
http://maxdb.sap.com/). It is intended to be used in JRuby environment
only and is an extension of the [ActiveRecord JDBC Adapter project](
https://github.com/jruby/activerecord-jdbc-adapter).

This gem requires the [jdbc-maxdb gem](https://github.com/sapnwcloudlabs/jdbc-maxdb-gem).

The adapter works for Rails 3.

To install the gem you would have to build it from source:

    jruby -S gem build activerecord-maxdb-adapter.gemspec
	jruby -S gem install activerecord-maxdb-adapter

	
To use it add this in your database.yml configuration:

    development:
	  adapter: maxdb
	  encoding: utf8
	  reconnect: false
	  host: <your_MaxDB_host>
	  database: <your_MaxDB_database>
	  pool: 5
	  username: <your_MaxDB_user_name>
	  password: <your_MaxDB_password>
	  
JNDI setting is supported as well (this is coming from the generic AR-JDBC Adapter):

    production:
	  adapter: maxdb
	  encoding: utf8
	  reconnect: false
	  jndi: java:comp/env/jdbc/myMaxDBDataSource
	  pool: 5
	  
	  
## Known issues

If you have an User model in your application, which most probably means that it should be
mapped to a Users table (ActiveRecord pluralization is used by convention), you might
encounter issues with using the adapter. We recommend you to override the default mapping
behavour, for example by adding this line in config/application.rb (or config/environment.rb):

    config.active_record.table_name_prefix = <some_prefix>

or by just turning off the table name pluralization:

    config.active_record.pluralize_table_names = false

Any other modification which makes the table name different from Users will do.