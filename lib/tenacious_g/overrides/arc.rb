module GRATR #:nodoc:
  # I don't like the MultiArc and MultiEdge interface, it forces me to
  # number them manually.  This uses UUIDs to number the edges.  I call
  # this the key, and store it on @
  # __key 
  class Arc < Struct::ArcBase
    def key
      @__key ||= UUID.generate
    end
  end
end
