require File.dirname(__FILE__) + '/../../spec_helper'

describe GRATR::Graph do
  it "should have a kind inspect" do
    g = Digraph.new
    g.inspect.should eql("GRATR::Digraph[].")
    g.add_edge!(1,2)
    g.inspect.should eql("GRATR::Digraph[GRATR::Arc[1,2,nil]].")
    g.add_edge!(3,4)
    g.add_edge!(1,3)
    g.add_edge!(8,3)
    g.add_edge!(7,1)
    g.add_edge!(6,2)
    g.add_edge!(4,5)
    g.inspect.should eql("GRATR::Digraph[8 vertices and 7 edges]")
    g.add_edge!(100,101)
    g.inspect.should eql("GRATR::Digraph[10 vertices and 8 edges]")
  end
end
