# encoding: UTF-8
class RList < DList
    attr_accessor :letter #letra para los sufijos de los años
  def initialize(content = nil)
      content= ordenar_externo(content)
  super(content)
  sufijos
  end
  
def insert(content)
    insert_h(content)
    quitarsufijos
    ordenar_interno
end 

def ordenar_externo(content)
    orden = content.sort_by{|ref| ref}.reverse!
    orden
end
  
  
  def ordenar_interno
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
     aux=@head
     letter="a"
     while aux!=nil
     year = aux["value"].p_date
     while  aux["next"]!=nil && aux["value"].author_surname==aux["next"]["value"].author_surname && year==aux["next"]["value"].p_date
     aux["value"].p_date=aux["value"].p_date + letter
     year=aux["next"]["value"].p_date
     aux=aux["next"]
     letter=letter.next
          if  aux["next"]==nil || (aux["value"].author_surname!=aux["next"]["value"].author_surname && aux["value"].p_date!=aux["next"]["value"].p_date) 
         aux["value"].p_date=aux["value"].p_date + letter
     end

 end
   letter="a"
     aux = aux["next"]    
 end
 end
 
 def quitarsufijos
     aux=@head
     while aux!=nil
    aux["value"].p_date=aux["value"].p_date.tr('^0-9', '')
     aux = aux["next"]    
 end
 end
 
 def salida_funcional
 libro = Proc.new{|node| 
 fullnames = ""
          i=0
  while i < node["value"].author_name.count
if i != node["value"].author_name.count-1
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}. & "
else
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}."
end
  i=i+1
end
      "#{fullnames} (#{node["value"].p_date}). #{node["value"].title} (#{node["value"].edit_num}) (#{node["value"].volume}). #{node["value"].p_place}: #{node["value"].p_house}."}
      
      libroeditado = Proc.new{|node| 
 editors = ""
 fullnames = ""
          i=0
  while i < node["value"].author_name.count
if i != node["value"].author_name.count-1
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}. & "
else
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}."
end
  i=i+1
end
i=0
  while i < node["value"].editors.count
if i == node["value"].editors.count-1
  editors= editors + "#{node["value"].editors[i]}"
elsif i == node["value"].editors.count-2
  editors= editors + "#{node["value"].editors[i]} & "
 else
 editors= editors + "#{node["value"].editors[i]}, "
end
  i=i+1
end
      "#{fullnames} (#{node["value"].p_date}). #{node["value"].title_a}. En #{editors} (comps), #{node["value"].title} (pp. #{node["value"].pages}) (#{node["value"].edit_num}) (#{node["value"].volume}). #{node["value"].p_place}: #{node["value"].p_house}."
 }
    periodico= Proc.new{|node|
     fullnames = ""
          i=0
  while i < node["value"].author_name.count
if i != node["value"].author_name.count-1
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}. & "
else
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}."
end
  i=i+1
end
      "#{fullnames} (#{node["value"].p_date}). #{node["value"].title_a}. #{node["value"].title}, pp. #{node["value"].pages}."
    }
    
    edoc= Proc.new{|node|
           fullnames = ""
          i=0
  while i < node["value"].author_name.count
if i != node["value"].author_name.count-1
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}. & "
else
  fullnames= fullnames + "#{node["value"].author_surname[i]}, #{node["value"].author_name[i][0]}."
end
  i=i+1
end
 if node["value"].medium =="En línea"
      "#{fullnames} (#{node["value"].p_date}). #{node["value"].title} (#{node["value"].edit_num}), [#{node["value"].medium}]. #{node["value"].p_place}: #{node["value"].p_house}. Disponible en: #{node["value"].url} [#{node["value"].a_date}]."
 else
     "#{fullnames} (#{node["value"].p_date}). #{node["value"].title} (#{node["value"].edit_num}), [#{node["value"].medium}]. #{node["value"].p_place}: #{node["value"].p_house} [#{node["value"].a_date}]."
 end
    }
      aux = @head
    cadena=""
while aux!=nil
    if aux["next"]!=nil
        if aux["value"].class.to_s=="Book"
    cadena= cadena+"[#{libro.call(aux)}]<-->"
    elsif aux["value"].class.to_s=="EBook"
    cadena= cadena+"[#{libroeditado.call(aux)}]<-->"
    elsif aux["value"].class.to_s=="Newspaper"
    cadena= cadena+"[#{periodico.call(aux)}]<-->"
    elsif aux["value"].class.to_s=="EDoc"
    cadena= cadena+"[#{edoc.call(aux)}]<-->"
end
else
     if aux["value"].class.to_s=="Book"
    cadena= cadena+"[#{libro.call(aux)}]"
    elsif aux["value"].class.to_s=="EBook"
    cadena= cadena+"[#{libroeditado.call(aux)}]"
    elsif aux["value"].class.to_s=="Newspaper"
    cadena= cadena+"[#{periodico.call(aux)}]"
    elsif aux["value"].class.to_s=="EDoc"
    cadena= cadena+"[#{edoc.call(aux)}]"
end
end
    aux=aux["next"]
end
cadena
 end
 
end