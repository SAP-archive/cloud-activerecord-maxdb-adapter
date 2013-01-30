# arjdbc/discover.rb: Declare ArJdbc.extension modules in this file
# that loads a custom module and adapter.

module ::ArJdbc  
  extension :MaxDB do |name|  
    require 'arjdbc/maxdb'
    name =~ /max/i
    true
  end
end
