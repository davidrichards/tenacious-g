require File.join(File.dirname(__FILE__), "/spec_helper")

describe TenaciousG do
  
  it "should have rubygems available" do
    defined?(Gem).should_not be_nil
  end
  
  it "should have GRATR available" do
    defined?(GRATR).should_not be_nil
  end
  
  it "should have UUID available" do
    defined?(UUID).should_not be_nil
  end
  
  it "should have TenaciousGError available" do
    defined?(TenaciousGError).should_not be_nil
  end
  
  it "should have NotImplemented available" do
    defined?(NotImplemented).should_not be_nil
  end
  
end

# Setup in tenacious_g.rb, so putting the specs here so I can find them.
describe "GRATR implementation" do
  it "should have the persistence module included in Digraph" do
    GRATR::Digraph.included_modules.should be_include(TenaciousG::Persistence)
  end

  it "should have the persistence module included in UndirectedGraph" do
    GRATR::UndirectedGraph.included_modules.should be_include(TenaciousG::Persistence)
  end
  
  it "should be able to load objects from the pstore" do
    class A
      attr_accessor :special_var
      include Persistence
    end
    a = A.new
    a.special_var = 123
    lambda{a.save}.should_not raise_error
    lambda{@a = GRATR.load('graph')}.should_not raise_error
    @a.should be_is_a(A)
    @a.special_var.should eql(123)
    Object.send(:remove_const, :A)
  end
end