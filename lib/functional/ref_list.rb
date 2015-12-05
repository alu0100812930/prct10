class RList < DList
  def initialize(content = nil)
  super
  ordenar
  end
  
  def ordenar
     orden = sort_by{|node| node["value"]}
     if (orden.count > 1)
     extract_all
     for i in 0..orden.count-1
     insert_e(orden[i]["value"])
   end
 end
 end
end