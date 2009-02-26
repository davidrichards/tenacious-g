module TenaciousG #:nodoc:
  # This should probably go away, but I would like to have a few tools
  # while I play with setting this system up. 
  class Playground
    
    attr_accessor :n
    def initialize(n=1000)
      @n = n
    end
    
    def generate
      self.n.times { self.add_edge }
      self.graph.save
      self.graph
    end
    
    def graph
      @g ||= GRATR.load
      @g ||= Digraph.new
    end
    
    def random_new_node
      rand(self.n)
    end
    
    def random_vertex
      v = random_new_node if graph.size == 0
      v ||= graph[rand(graph.size)]
    end
    
    def add_edge
      graph.add_edge!(random_vertex, random_new_node)
    end
  end
end