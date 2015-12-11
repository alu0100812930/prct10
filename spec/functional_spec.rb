# encoding: UTF-8
require 'spec_helper'

describe Functional do
 before:each do 
        @diario= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "Más cerca", :title => "El Mercurio", :p_date => "2008", :pages => "4, Suplemento Deportes")
        @libro = Book.new(:author_name => ["Dave", "Albert", "Chad"], :author_surname => ["Thomas", "Hunt", "Fowler"], :p_date => "2013", :title => "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide", :volume =>1, :p_place =>"Ohio", :p_house => "Pragmatic Bookshelf",:edit_num => 4)
        @libroeditado= EBook.new(:author_name => "Javier", :author_surname => "Castanigno", :editor_name => ["Juan", "Manuel"] ,:editor_surname => ["Aguad", "Gutiérrez"], :title_a => "Técnicas, materiales y aplicaciones en nanotecnología", :title => "La Nueva Bioquímica", :volume => "3", :edit_num => 2, :pages => "189-191", :p_date => "2007", :p_place => "Madrid", :p_house => "Espasa")
        @edoc= EDoc.new(:author_name => ["Scott","Bob"],:author_surname => ["Chacon", "Straub"], :p_date=> "2009", :title => "Pro Git 2009th Edition", :edit_num => 5, :URL => "https:\\git-scm.com\book\en\v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2008, 22 de Mayo", :medium => "En línea")
    end
    
    it "Se pueden devolver salidas formateadas en APA de las referencias desde la clase RList usando un método con objetos Proc" do
    @listar= RList.new([@libro, @libroeditado, @diario, @edoc])
           expect(@listar.salida_funcional).to be == "Aguad, J. (2008). Más cerca. El Mercurio, pp. 4, Suplemento Deportes.\nCastanigno, J. (2007). Técnicas, materiales y aplicaciones en nanotecnología. En J. Aguad & M. Gutiérrez (comps), La Nueva Bioquímica (pp. 189-191) (2) (3). Madrid: Espasa.\nChacon, S. & Straub, B. (2009). Pro Git 2009th Edition (5), [En línea]. Tenerife: Drago. Disponible en: https:\\git-scm.com\book\en\v2 [2008, 22 de Mayo].\nThomas, D. & Hunt, A. & Fowler, C. (2013). Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide (4) (1). Ohio: Pragmatic Bookshelf.\n"
   end
    
    it "Las entradas de la lista de referencias debe estar en orden alfabético de acuerdo a los apellidos del primer autor de cada trabajo." do
      @listar= RList.new([@libro, @libroeditado, @diario, @edoc])
      expect(@listar.to_s).to be == "#{@diario}\n#{@libroeditado}\n#{@edoc}\n#{@libro}\n"
    end
    
    it "Si tiene más de un artículo del (los) mismo autor(es) (referencias de un autor solo o referencias de múltiples autores con exactamente los mismos autores en exactamente el mismo orden de aparición) ordene de acuerdo al año de publicación, comenzando con el más antiguo." do
       @diario2= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "Más cerca", :title => "El Mercurio", :p_date => "2009", :pages => "4, Suplemento Deportes")
        @diario3= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "Más cerca", :title => "El Mercurio", :p_date => "2007", :pages => "4, Suplemento Deportes")
      @edoc2= EDoc.new(:author_name => ["Scott", "Bob"], :author_surname => ["Chacon", "Straub"], :p_date=> "2005", :title => "Pro Git 2010th Edition", :edit_num => 5, :URL => "https:\\git-scm.com\book\en\v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2010, 22 de Mayo", :medium => "En línea")
       @edoc3= EDoc.new(:author_name => ["Scott", "Bob"], :author_surname => ["Chacon", "Straub"], :p_date=> "2011", :title => "Pro Git 2011th Edition", :edit_num => 5, :URL => "https:\\git-scm.com\book\en\v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2011, 22 de Mayo", :medium => "En línea")
      @listar= RList.new([@diario3, @diario2, @diario, @edoc3, @edoc2, @edoc])
      expect(@listar.to_s).to be == "#{@diario3}\n#{@diario}\n#{@diario2}\n#{@edoc2}\n#{@edoc}\n#{@edoc3}\n"
    end
    
    it "Cuando un autor aparezca tanto como un autor solo y, en otra cita, como el primer autor de un grupo, liste primero las entradas de un autor." do
      @edoc2= EDoc.new(:author_name=> "Scott", :author_surname => "Chacon", :p_date=> "2010", :title => "Pro Git 2010th Edition", :edit_num => 5, :URL => "https:\\git-scm.com\book\en\v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2010, 22 de Mayo", :medium => "En línea")
    @edoc3= EDoc.new(:author_name => ["Chad", "Bob", "William"], :author_surname => ["Chacon", "Straub", "Smith"], :p_date=> "2011", :title => "Pro Git 2011th Edition", :edit_num => 5, :URL => "https:\\git-scm.com\book\en\v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2011, 22 de Mayo", :medium => "En línea")
    @listar= RList.new([@edoc, @edoc2, @edoc3])
      expect(@listar.to_s).to be == "#{@edoc2}\n#{@edoc}\n#{@edoc3}\n"
    end
    
    it "Si está usando más de una referencia del mismo autor (o el mismo grupo de autores listados en el mismo orden) publicados en el mismo año, organícelos en la lista de referencias alfabéticamente de acuerdo al título del artículo o del capítulo. Entonces asigne letras al año como sufijos. Cuando se refiera a estas publicaciones en su escrito utilice las letras de sufijos con el año para que el lector sepa a cuál referencia se está refiriendo. " do
   @diario2= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "El atardecer", :title => "El Mercurio", :p_date => "2008", :pages => "4, Suplemento Deportes")
   @diario3= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "Problemas", :title => "El Mercurio", :p_date => "2008", :pages => "4, Suplemento Deportes")
    @diario4= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "Altura", :title => "El Mercurio", :p_date => "2008", :pages => "4, Suplemento Deportes")
     @listar= RList.new([@diario4, @diario, @diario2, @diario3, @edoc])
      expect(@listar.to_s).to be == "#{@diario4}\n#{@diario2}\n#{@diario}\n#{@diario3}\n#{@edoc}\n"
      expect(@diario4.p_date).to be == "2008a"
      expect(@diario2.p_date).to be == "2008b"
      expect(@diario.p_date).to be == "2008c"
      expect(@diario3.p_date).to be == "2008d"
      expect(@edoc.p_date).to be == "2009"
    end
    
   it "Se pueden insertar nuevas referencias a una lista, hacer extracciones y esta seguirá ordenada" do
        @diario2= Newspaper.new(:author_name => "Juan", :author_surname => "Aguad", :title_a => "El atardecer", :title => "El Mercurio", :p_date => "2008", :pages => "4, Suplemento Deportes")
      @edoc2= EDoc.new(:author_name => ["Scott", "Bob"], :author_surname => ["Chacon", "Straub"], :p_date=> "2010", :title => "Pro Git 2010th Edition", :edit_num => 5, :URL => "https:\\git-scm.com\book\en\v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2010, 22 de Mayo", :medium => "En línea")
       @listar= RList.new([@libro, @libroeditado, @diario, @edoc])
       @listar.insert(@diario2)
       expect(@listar.to_s).to be == "#{@diario2}\n#{@diario}\n#{@libroeditado}\n#{@edoc}\n#{@libro}\n"
       @listar.insert(@edoc2)
       expect(@listar.to_s).to be == "#{@diario2}\n#{@diario}\n#{@libroeditado}\n#{@edoc}\n#{@edoc2}\n#{@libro}\n"
       @listar.extract_head
       expect(@listar.to_s).to be == "#{@diario}\n#{@libroeditado}\n#{@edoc}\n#{@edoc2}\n#{@libro}\n"
       @listar.extract_end
       expect(@listar.to_s).to be == "#{@diario}\n#{@libroeditado}\n#{@edoc}\n#{@edoc2}\n"
   end
   
   
    it "La lista de referencias sólo admite objetos o arrays de objetos de referencias" do
     @listar= RList.new([@libro, @libroeditado, @diario, @edoc])
     expect(@listar).to be_a RList
     expect{RList.new(3)}.to raise_error(ArgumentError) 
     expect{@listar.insert([@edoc, "a"])}.to raise_error(ArgumentError)
    end
end
