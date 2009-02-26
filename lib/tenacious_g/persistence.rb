module TenaciousG #:nodoc:
  module Persistence #:nodoc:
    require 'pstore'
    
    include TaintingMethods
    
    module ClassMethods #:nodoc:

      # Use this like g = GRATR.load('my_graph')
      def load(name, dir=nil)
        dir ||= File.expand_path(File.join(ENV['HOME'], '.tenacious_g'))
        filename = "graph_db.pstore"
        location = File.expand_path(File.join(dir, filename))
        pstore = PStore.new(location)
        instance << pstore.transaction { pstore[name] }
        current
      end

      # A quasi-singleton that keeps track of whatever I've been working on.
      def instance
        @@instance ||= []
      end
      
      # The most recent graph.
      def current
        instance.last
      end
      
      # Finds or loads a graph.
      def find(name, dir=nil)
        found = instance.find {|graph| graph.name == name}
        found ||= load(name, dir)
      end
    end
    
    # For tonight, I'm going to save the whole graph at once!!
    def save
      pstore.transaction { pstore[self.name] = self }
    end
    
    # This gives us access to the persistent store.  
    def pstore
      @pstore ||= PStore.new(self.location)
    end
    protected :pstore
    
    # If you change the location (name or directory) on the graph, this will be called.
    def reset_pstore; @pstore = nil end

    # You can set the name of the graph.
    def name=(str)
      @name = str
      reset_pstore
    end
    
    # This is the name of the graph.  Defaults to graph.
    def name
      @name ||= 'graph' 
    end

    # Just using a standard name for now.
    def filename
      "graph_db.pstore"
    end
    
    # The name of the directory to store the persistent store.
    def directory=(str)
      @directory = str
      reset_pstore
    end
    
    # The name of the directory to store the persistent store.  Defaults to
    # ~/.tenacious_g 
    def directory
      @directory ||= File.expand_path(File.join(ENV['HOME'], '.tenacious_g'))
    end

    # This is the full path to the location of the persistent store.  It
    # should be a local file somewhere. 
    def location
      File.mkdir_p(directory)
      @location ||= File.join(self.directory, self.filename)
    end
  end
end