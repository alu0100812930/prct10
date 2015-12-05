class RList < DList
    attr_accessor :letter #letra para los sufijos de los años
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
   sufijos
 end
 end
 
 def sufijos
     letter="a"
     aux=@head
     while aux!=nil
     year = aux["value"].p_date
     while  aux["next"]!=nil && aux["value"].author==aux["next"]["value"].author && year==aux["next"]["value"].p_date
     aux["value"].p_date=aux["value"].p_date.to_s + letter
     year=aux["next"]["value"].p_date
     aux=aux["next"]
     letter=letter.next
          if  aux["next"]==nil || (aux["value"].author!=aux["next"]["value"].author && aux["value"].p_date!=aux["next"]["value"].p_date) 
         aux["value"].p_date=aux["value"].p_date.to_s + letter
     end

 end
   letter="a"
     aux = aux["next"]    
 end
 end
end