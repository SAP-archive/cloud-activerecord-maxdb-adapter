# ActiveRecord JDBC adapter for SAP MaxDB database

This is an ActiveRecord JDBC adapter for the [SAP MaxDB database](
http://maxdb.sap.com/). It is intended to be used in JRuby environment
only and is an extension of the [ActiveRecord JDBC Adapter project](
https://github.com/jruby/activerecord-jdbc-adapter).

This gem requires the [jdbc-maxdb gem](https://github.com/sapnwcloudlabs/jdbc-maxdb-gem).

To install the gem you would have to build it from source:

    jruby -S gem build activerecord-maxdb-adapter.gemspec
	jruby -S gem install activerecord-maxdb-adapters

	
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
