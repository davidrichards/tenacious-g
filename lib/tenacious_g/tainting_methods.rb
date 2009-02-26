module TenaciousG #:nodoc:
  module TaintingMethods
    def tainting_methods(*args)
      append_tainting_methods(*args)
      @tainting_methods
    end
    
    # Keeps track of which methods are tainting
    def append_tainting_methods(*args)
      @tainting_methods ||= []
      args.each do |arg|
        arg = arg.to_sym
        add_tainted_method(arg) unless @tainting_methods[arg]
      end
    end
    
    def add_tainted_method(method_sym)
      # # archive_method(method_sym, :prefix => "untainted_") if method_defined?(method_sym)
      # m = lambda{}
      # define_method(with_tain(method_sym), m)
      # alias_method_chain :, :
      # def go
      #   'go'
      # end
      # def go_with_flair
      #   go_without_flair + " flair"
      # end
      # alias_method_chain :go, :flair
      # 
    end
    
    def with_taint(sym); sym.to_str + "_with_taint" end
    def without_taint(sym); sym.to_str + "_with_taint" end
    
  end
end