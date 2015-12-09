# encoding: UTF-8
class Biblioref
  include Comparable
  attr_accessor :author_name
  attr_accessor :author_surname
      attr_accessor :title
      attr_accessor :p_house #Casa editorial
      attr_accessor :p_place #Lugar de publicación
      attr_accessor :edit_num #Numero de edición
      attr_accessor :p_date #Fecha de publicación
      attr_accessor :volume #Volumen
      def initialize(params = {})
          @author_name = []
          @author_surname = []
          if params.fetch(:author_name, nil).class.to_s=="Array"
            for i in 0..params.fetch(:author_name, nil).count-1
            @author_name << params.fetch(:author_name, nil)[i]
              @author_surname << params.fetch(:author_surname, nil)[i]
          end
          else
             @author_name << params.fetch(:author_name, nil)
              @author_surname << params.fetch(:author_surname, nil)
          
          end
          @title = params.fetch(:title,nil)
          @volume= params.fetch(:volume, nil)
          @p_house = params.fetch(:p_house, nil)
          @edit_num = params.fetch(:edit_num, nil)
          @p_date = params.fetch(:p_date, nil)
          @p_place = params.fetch(:p_place, nil)
          end
          
      def to_s
          fullnames = ""
          i=0
  while i < @author_name.count
if i != @author_name.count-1
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}. & "
else
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}."
end
  i=i+1
end
      "#{fullnames} (#{@p_date}). #{@title} (#{@edit_num}) (#{@volume}). #{@p_place}: #{@p_house}."
    end 
    
     def <=> (another)
       if (@author_surname != another.author_surname)
      @author_surname<=>another.author_surname
  elsif (@author_surname == another.author_surname && @p_date!=another.p_date)
    @author_surname<=>another.author_surname
    @p_date<=>another.p_date
  end
    end
end

class Book < Biblioref
    def initialize(params ={})
        super
    end
    def to_s
        super
end

def <=>(another)
  if @author_surname== another.author_surname && @p_date==another.p_date
    @title<=>another.title
  else
      super
    end
end
end

class EBook < Biblioref
    attr_accessor :title_a, #Título de artículo
    :editors, #Editores de artículo
    :pages #Paginas de artículo
    def initialize(params = {})
        super
        @editors = []
         if params.fetch(:editors, nil).class.to_s=="Array"
            for i in 0..params.fetch(:editors, nil).count-1
            @editors << params.fetch(:editors, nil)[i]
          end
      end
        @title_a=params.fetch(:title_a)
        @volume=params.fetch(:volume, "")
        @pages=params.fetch(:pages)
    end
    
    def to_s
          editors = ""
 fullnames = ""
          i=0
  while i < @author_name.count
if i != @author_name.count-1
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}. & "
else
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}."
end
  i=i+1
end
i=0
  while i < @editors.count
if i == @editors.count-1
  editors= editors + "#{@editors[i]}"
elsif i == @editors.count-2
  editors= editors + "#{@editors[i]} & "
 else
 editors= editors + "#{@editors[i]}, "
end
  i=i+1
end
      "#{fullnames} (#{@p_date}). #{@title_a}. En #{editors} (comps), #{@title} (pp. #{@pages}) (#{@edit_num}) (#{@volume}). #{@p_place}: #{@p_house}."
    end 
    
   def <=>(another)
        if @author_surname== another.author_surname && @p_date==another.p_date
    @author_surname<=>another.author_surname
    @title_a<=>another.title_a
else
  super
end
end
end

class Newspaper < Biblioref
  attr_accessor :title_a, #Título de artículo
  :pages #Paginación
  def initialize(params = {})
    super
    @title_a=params.fetch(:title_a)
    @pages= params.fetch(:pages)
  end
  
        def to_s
  fullnames = ""
          i=0
  while i < @author_name.count
if i != @author_name.count-1
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}. & "
else
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}."
end
  i=i+1
end
      "#{fullnames} (#{@p_date}). #{@title_a}. #{@title}, pp. #{@pages}."
   end
     def <=>(another)
        if @author_surname == another.author_surname && @p_date==another.p_date
          @author_surname<=>another.author_surname
    @title_a<=>another.title_a
else
  super
end
end
end

class EDoc < Biblioref
   attr_accessor :url, #Dirección de documento electrónico
   :medium, #Medio
   :a_date #Fecha de acceso a medio
    def initialize(params ={})
        super
        @url=params.fetch(:URL)
        @a_date=params.fetch(:a_date)
        @medium=params.fetch(:medium)
    end
    
      def to_s
         fullnames = ""
          i=0
  while i < @author_name.count
if i != @author_name.count-1
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}. & "
else
  fullnames= fullnames + "#{@author_surname[i]}, #{@author_name[i][0]}."
end
  i=i+1
end
 if @medium =="En línea"
      "#{fullnames} (#{@p_date}). #{@title} (#{@edit_num}), [#{@medium}]. #{@p_place}: #{@p_house}. Disponible en: #{@url} [#{@a_date}]."
 else
     "#{fullnames} (#{@p_date}). #{@title} (#{@edit_num}), [#{@medium}]. #{@p_place}: #{@p_house} [#{@a_date}]."
 end
end

def <=>(another)
  if @author_surname == another.author_surname && @p_date==another.p_date
    @author_surname<=>another.author_surname
    @title<=>another.title
  else
      super
    end
end

end