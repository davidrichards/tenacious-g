module GRATR #:nodoc:
  module Graph #:nodoc:
    alias :old_inspect :inspect
    def inspect
      case
      when old_inspect.size > 80
        self.class.to_s + 
        "[#{self.vertices.size} vertices and #{self.edges.size} edges]"
      else
        old_inspect
      end
    end
  end
end