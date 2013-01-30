class ActiveRecord::Base
  class << self
    def maxdb_connection( config )
      config[:port] ||= 7200
      config[:url] ||= "jdbc:sapdb://#{config[:host]}/#{ config[:database]}"
      config[:driver] ||= "com.sap.dbtech.jdbc.DriverSapDB"
      config[:adapter_class] = ActiveRecord::ConnectionAdapters::MaxDBSQLAdapter
      jdbc_connection(config)
    end
  end
end