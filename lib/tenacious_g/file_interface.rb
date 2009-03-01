module TenaciousG #:nodoc:
  
  # This is a specialized interface for marshaling/unmarshalling reading/
  # writing files in one step.  It's pretty permissive with locations and
  # file names, enforcing the graph naming convention location/name.graph. 
  class FileInterface
    class << self
      
      # Usage: read(:my_name)
      # read(:my_name, :location => 'some/location')
      def read(name, opts={})
        location = infer_location(opts[:location])
        name = infer_name(name)
        contents = safe_read(name, location)
        return contents ? Marshal.load(contents) : nil
      end
      
      # Usage: write(:my_name, :contents => "some marshalable contents")
      # write(:my_name, :location => "some/location", :contents => "whatever")
      # write(:my_name) {some block that generates content}
      def write(name, opts={}, &block)
        if block
          contents = block.call
        else
          contents = opts[:contents]
        end
        location = infer_location(opts[:location])
        name = infer_name(name)
        fp = File.open(File.join(location, name), "w")
        fp.write(Marshal.dump(contents))
        fp.close
      end
      
      def safe_read(name, location)
        path = File.join(location, name)
        return nil unless File.exist?(path)
        File.read(path)
      end
      protected :safe_read
      
      def infer_location(location=nil)
        case
        when location.nil?
          default_location
        when location.is_a?(Dir)
          # Dir requires that the directory exists.
          location.path
        when (location.is_a?(File) and File.directory?(location))
          location.path
        when (location.is_a?(File) and File.file?(location))
          # Grabs everything from root to the directory, not including the file.
          File.split(location.path)[0]
        when (location and File.exist?(location))
          location
        when (location and not File.exist?(location))
          File.mkdir_p(location)
        else
          raise ArgumentError, "Can't infer the location from #{location.inspect}"
        end
      end
      protected :infer_location
      
      def default_location
        File.expand_path("~/.tenacious_g")
      end
      
      def infer_name(name)
        case name
        when /.+\.graph$/
          name
        when String
          name + ".graph"
        else
          begin
            name.to_s + ".graph"
          rescue Exception => e
            raise "Cannot infer name from #{name.inspect}\n#{e.inspect}\n#{e.backgtrace.join("\n")}"
          end
        end
      end
      protected :infer_name
      
    end
  end
end
