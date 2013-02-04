require 'arjdbc/jdbc'

# This is not needed since AR-JDBC Adapter version 1.2.6, and moreover causes an error.
# Please uncomment it for versions prior to 1.2.6
# jdbc_require_driver 'jdbc/maxdb'

require 'arjdbc/maxdb/connection_methods'
require 'arjdbc/maxdb/adapter'
