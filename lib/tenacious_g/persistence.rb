module TenaciousG #:nodoc:
  module Persistence #:nodoc:
    require 'pstore'
    
    include TaintingMethods
    
    module ClassMethods #:nodoc:

      # Use this like g = GRATR.load('my_graph')
      def load(name='graph', dir=nil)
        pstore = PStore.new(self.location)
        instance << pstore.transaction { pstore[name] }
        current
      end
      
      def location
        dir ||= File.expand_path(File.join(ENV['HOME'], '.tenacious_g'))
        filename = "graph_db.pstore"
        location = File.expand_path(File.join(dir, filename))
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
    
    def save(name=nil)
      self.name = name if name
      pstore.transaction { pstore[self.name] = self }
    end
    alias :save_as :save
    
    # This gives us access to the persistent store.  
    def pstore
      @pstore ||= PStore.new(self.location)
    end
    protected :pstore
    
    # You can set the name of the graph.
    attr_writer :name
    # This is the name of the graph.  Defaults to graph.
    def name
      @name ||= 'graph' 
    end

    # Just using a standard name for now.
    def filename
      "graph_db.pstore"
    end
    
    # If you change the location (directory) on the graph, this needs to be
    # called. 
    def reset_pstore; @pstore = nil end

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