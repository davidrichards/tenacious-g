require File.dirname(__FILE__) + '/../../spec_helper'

describe GRATR::Arc, "key" do
  it "should have a key available" do
    g = GRATR::Digraph.new
    g.add_edge!(1,2)
    key = g.edges.first.key
    key.should be_is_a(String)
    split_key = key.split("-")
    # Looks like a UUID, acts like a UUID, good enough.
    split_key.map{|part| part.size}.should eql([8, 4, 4, 4, 12])
  end
end

describe GRATR::Arc, "persistence" do
  before(:each) do
    g = GRATR::Digraph.new
    g.add_edge!(1,2)
    @arc = g.edges.first
  end
  
  # it "should have a save method" do
  # end
end
