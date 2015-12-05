# encoding: UTF-8

require 'spec_helper'

describe Functional do
 before:all do 
        @diario= Newspaper.new(:author => "Aguad, J.", :title_a => "Más cerca", :title => "El Mercurio", :p_date => 2008, :pages => "4, Suplemento Deportes")
        @libro = Book.new(:author => ["Thomas, D.", "Hunt, A.", "Fowler, C."], :p_date => 2013, :title => "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide", :volume =>1, :p_place =>"Ohio", :p_house => "Pragmatic Bookshelf",:edit_num => 4)
        @libroeditado= EBook.new(:author => "Castanigno, J.", :editors => ["J. Aguad", "M. Gutiérrez"], :title_a => "Técnicas, materiales y aplicaciones en nanotecnología", :title => "La Nueva Bioquímica", :volume => "3", :edit_num => 2, :pages => "189-191", :p_date => 2007, :p_place => "Madrid", :p_house => "Espasa")
        @edoc= EDoc.new(:author => ["Chacon, S.", "Straub, B."], :p_date=> 2009, :title => "Pro Git 2009th Edition", :edit_num => 5, :URL => "https://git-scm.com/book/en/v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2008, 22 de Mayo", :medium => "En línea")
    end
    
    it "La salida en pantalla de los objetos de las referencias se corresponden con el formato de la Asociación de Psicología Americana" do
      expect(@libro.to_s).to be == "Thomas, D. & Hunt, A. & Fowler, C. (2013). Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide (4) (1). Ohio: Pragmatic Bookshelf."
      expect(@libroeditado.to_s).to be == "Castanigno, J. (2007). Técnicas, materiales y aplicaciones en nanotecnología. En J. Aguad & M. Gutiérrez (comps), La Nueva Bioquímica (pp. 189-191) (2) (3). Madrid: Espasa."
      expect(@diario.to_s).to be == "Aguad, J. (2008). Más cerca. El Mercurio, pp. 4, Suplemento Deportes."
      expect(@edoc.to_s).to be == "Chacon, S. & Straub, B. (2009). Pro Git 2009th Edition (5), [En línea]. Tenerife: Drago. Disponible en: https://git-scm.com/book/en/v2 [2008, 22 de Mayo]."
    end
    
    it "Las entradas de la lista de referencias debe estar en orden alfabético de acuerdo a los apellidos del primer autor de cada trabajo." do
      @listar= RList.new([@libro, @libroeditado, @diario, @edoc])
      expect(@listar.to_s).to be == "[#{@diario}]<-->[#{@libroeditado}]<-->[#{@edoc}]<-->[#{@libro}]"
    end
    
    it "Si tiene más de un artículo del (los) mismo autor(es) (referencias de un autor solo o referencias de múltiples autores con 
    exactamente los mismos autores en exactamente el mismo orden de aparición) ordene de acuerdo al año de publicación, comenzando con el 
    más antiguo." do
       @diario2= Newspaper.new(:author => "Aguad, J.", :title_a => "Más lejos", :title => "El Mercurio", :p_date => 2009, :pages => "4, Suplemento Deportes")
       @diario3= Newspaper.new(:author => "Aguad, J.", :title_a => "Intermedio", :title => "El Mercurio", :p_date => 2007, :pages => "4, Suplemento Deportes")
      @edoc2= EDoc.new(:author => ["Chacon, S.", "Straub, B."], :p_date=> 2005, :title => "Pro Git 2010th Edition", :edit_num => 5, :URL => "https://git-scm.com/book/en/v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2010, 22 de Mayo", :medium => "En línea")
       @edoc3= EDoc.new(:author => ["Chacon, S.", "Straub, B."], :p_date=> 2011, :title => "Pro Git 2011th Edition", :edit_num => 5, :URL => "https://git-scm.com/book/en/v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2011, 22 de Mayo", :medium => "En línea")
      @listar= RList.new([@diario3, @diario2, @diario, @edoc3, @edoc2, @edoc])
      expect(@listar.to_s).to be == "[#{@diario3}]<-->[#{@diario}]<-->[#{@diario2}]<-->[#{@edoc2}]<-->[#{@edoc}]<-->[#{@edoc3}]"
    end
    
    it "Cuando un autor aparezca tanto como un autor solo y, en otra cita, como el primer autor de un grupo, liste primero las entradas de un autor." do
      @edoc2= EDoc.new(:author => "Chacon, S.", :p_date=> 2010, :title => "Pro Git 2010th Edition", :edit_num => 5, :URL => "https://git-scm.com/book/en/v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2010, 22 de Mayo", :medium => "En línea")
    @edoc3= EDoc.new(:author => ["Chacon, S.", "Straub, B.", "Smith, W."], :p_date=> 2011, :title => "Pro Git 2011th Edition", :edit_num => 5, :URL => "https://git-scm.com/book/en/v2", :p_place=> "Tenerife", :p_house => "Drago", :a_date => "2011, 22 de Mayo", :medium => "En línea")
    @listar= RList.new([@edoc2, @edoc, @edoc3])
      expect(@listar.to_s).to be == "[#{@edoc2}]<-->[#{@edoc}]<-->[#{@edoc3}]"
    end
    
    
   
end
