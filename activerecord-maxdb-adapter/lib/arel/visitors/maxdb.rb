require 'arel/visitors/to_sql'

module Arel
  module Visitors
    class MaxDB < Arel::Visitors::ToSql
    
	 # Add logic for handling the OFFSET keyword. In MaxDB's SQL dialect, the offset 
	 # value is just appended after the limit one with a comma, aka: LIMIT 10, 8
	 # instead of the core Arel behaviour: LIMIT 10 OFFSET 8. So we override core Arel
	 # behaviour here.
	 # See http://maxdb.sap.com/doc/7_8/45/4c3b2746991798e10000000a1553f6/content.htm
	 # 
	 # Drawback: This code obviously relies on the fact that the core Arel library 
	 # visits the limit and offset nodes in this exact order.
	      
     def visit_Arel_Nodes_Offset o
        ", #{visit o.expr}"
      end
    end
    
    Arel::Visitors::VISITORS['maxdb'] = Arel::Visitors::MaxDB
  end
end