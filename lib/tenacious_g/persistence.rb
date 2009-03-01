module TenaciousG #:nodoc:
  module Persistence #:nodoc:
    
    include TaintingMethods
    
    module ClassMethods #:nodoc:

      # Use this like g = GRATR.load('my_graph')
      def load(name='graph', dir=nil)
        instance << FileInterface.read(name, :location => dir)
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
    
    def save(name=nil)
      self.name = name if name
      FileInterface.write(self.name, :contents => self, :location => self.directory)
    end
    alias :save_as :save
    
    # You can set the name of the graph.
    attr_writer :name
    # This is the name of the graph.  Defaults to graph.
    def name
      @name ||= 'stored_graph' 
    end

    # The name of the directory to store the persistent store.
    def directory=(str)
      @directory = str
    end
    
    # The name of the directory to store the persistent store.  Defaults to
    # ~/.tenacious_g 
    def directory
      @directory ||= File.expand_path(File.join(ENV['HOME'], '.tenacious_g'))
    end
    
    def filename
      self.name + ".graph"
    end

    # This is the full path to the location of the persistent store.  It
    # should be a local file somewhere. 
    def location
      File.mkdir_p(directory)
      @location ||= File.join(self.directory, self.filename)
    end
  end
end