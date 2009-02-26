require File.dirname(__FILE__) + '/../spec_helper'

# Assumes the setup is working: GRATR is using Persistence
describe Persistence do
  
  before(:each) do
    @g = Digraph.new
  end
  
  it "should have pstore required from the Standard Library" do
    defined?(PStore).should_not be_nil
  end
  
  it "should make location available" do
    default_location = File.expand_path(File.join(ENV['HOME'], %w(.tenacious_g graph_db.pstore)))
    @g.location.should eql(default_location)
  end
  
  it "should make directory available" do
    default_dir = File.expand_path(File.join(ENV['HOME'], %w(.tenacious_g)))
    @g.directory.should eql(default_dir)
    @g.directory = '/tmp'
    @g.directory.should eql('/tmp')
    @g.location.should eql('/tmp/graph_db.pstore')
  end
  
  it "should make name available" do
    default_name = 'graph'
    @g.name.should eql(default_name)
    @g.name = 'george'
    @g.name.should eql('george')
  end
  
  it "should use a pstore to store the graph" do
    @g.send(:pstore).should be_is_a(PStore)
  end
  
  it "should be able to save and load itself" do
    @g.add_edge!(1,2)
    lambda{@g.save}.should_not raise_error
    lambda{@a = GRATR.load('graph')}.should_not raise_error
    @g.should be_is_a(Digraph)
    @g.vertices.should be_include(1)
    @g.vertices.should be_include(2)
    @g.vertices.size.should eql(2)
  end
  
  it "should be able to name the graph while saving" do
    @g.add_edge!(3,4)
    @g.save_as('other_graph')
    @g.name.should eql('other_graph')
    @g = GRATR.load('other_graph')
    @g.vertices.should be_include(3)
    @g.vertices.should be_include(4)
    @g.vertices.size.should eql(2)
  end
  
end
