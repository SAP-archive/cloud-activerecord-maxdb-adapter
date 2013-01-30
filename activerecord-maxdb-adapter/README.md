activerecord-maxdb-adapter
===========================

This is an ActiveRecord adapter for the SAP MaxDB database. It is intended to serve as an extension to
the ActiveRecord-JDBC adapter project, and thus it is usable on Java/JRuby only. Noteworthy parts are:

- `lib/arjdbc/discover.rb`: This file gets loaded by
  activerecord-jdbc-adapter, and where we register our extension.  
- `lib/arjdbc/maxdb/adapter.rb`: Organize the ::ArJdbc::MaxDB code in here.
  In this module we define details for the SQL dialect, specific for MaxDB.
- `lib/arjdbc/maxdb/connection_methods.rb`: Here, the adapter figures out how to
  interpret database.yml configurations, that are targeted at it.
- `lib/active_record/connection_adapters/maxdb_adapter.rb`: This
  file is what allows ActiveRecord to load an adapter from its
  `adapter: maxdb` line in database.yml.
- `lib/arjdbc/maxdb.rb`: This file, apart from other stuff, requires the gem
  that carries the JDBC driver for MaxDB. 

=============================
Dependencies:

This gem depends on the activerecord-jdbc-adapter gem, version >= 1.0.0, since this
is the version that introduces the discovery mechanism.

This gem depends on the gem that packages the JDBC driver for MaxDB: jdbc-maxdb.


=============================
Building the gem:

$> gem build activerecord-maxdb-adapter.gemspec


=============================
Installing the gem: 

$> gem install activerecord-maxdb-adapter 
