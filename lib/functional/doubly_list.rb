class DList
    include Enumerable
       Node = Struct.new(:value,:before, :next)
    attr_accessor :head, :end_
  def initialize(content = nil)
      if (content != nil)
          insert_h(content)
  else
      @head=nil
  @end_=nil
  end
  end
  
  def insert_empty(content)
          node = Node.new(content)
          @head = node
          @end_ = node
  end
  
   def insert_head(content)
      if @head == nil
          insert_empty(content)
      else
          node = Node.new(content)
          node["next"] = @head
          @head = node
          @head["next"]["before"]=@head
      end
      
  end
  
def insert_h(content)
      if content.class.to_s == "Array"
          for i in 0..content.count-1
          insert_head(content[i])
      end
  else
      insert_head(content)
  end
end 

def insert_end(content)
      if @head == nil
          insert_empty(content)
      else
          node =  Node.new(content)
          before=@end_
          @end_["next"]=node
          @end_=node
          @end_["before"]=before
      end
      
  end
  
  def insert_e(content)
      if content.class.to_s == "Array"
          for i in 0..content.count-1
          insert_end(content[i])
      end
  else
      insert_end(content)
  end
  end
  
  def extract_head
if @head==@end_
        nodo=@head
        @head=nil
        @end_=nil
        nodo
else
    nodo=@head
    @head = @head["next"]
    @head["before"]=nil
    nodo
end

end

def extract_end
if @head==@end_
   nodo=@head
   @head=nil
   @end_=nil
   nodo
else
    nodo=@head
    while nodo["next"]!=@end_
    nodo=nodo["next"]
end
    @end_=nodo
    nodo=nodo["next"]
    @end_["next"]=nil
    nodo
   end 
end

  def extract_all
        aux=@head
        while aux!=nil
        aux=extract_head
    end
    end

def to_s
    aux = @head
    cadena=""
while aux!=nil
    if aux["next"]!=nil
    cadena= cadena+"[#{aux["value"]}]<-->"
else
    cadena=cadena= cadena+"[#{aux["value"]}]"
end
    aux=aux["next"]
end
cadena
end


def reverse
     aux = @end_
    cadena=""
while aux!=nil
    if aux["before"]!=nil
    cadena= cadena+"[#{aux["value"]}]<-->"
else
    cadena=cadena= cadena+"[#{aux["value"]}]"
end
    aux=aux["before"]
end
cadena
end

def each(&block)
  aux=@head
  nodes = []
  while aux!=nil
    nodes << aux
    aux=aux["next"]
end
nodes.each do |member|
      block.call(member)
    end
  
  
end
end