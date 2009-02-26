require File.join(File.dirname(__FILE__), "/spec_helper")

describe TenaciousG do
  
  it "should have rubygems available" do
    defined?(Gem).should_not be_nil
  end
  
  it "should have Gratr available" do
    defined?(GRATR).should_not be_nil
  end
  
  it "should have TenaciousGError available" do
    defined?(TenaciousGError).should_not be_nil
  end
  
  it "should have NotImplemented available" do
    defined?(NotImplemented).should_not be_nil
  end
  
end

# Setup in tenacious_g.rb, so putting the specs here so I can find them.
describe GRATR::Graph do
  it "should have the persistence module included" do
    GRATR::Graph.included_modules.should be_include(TenaciousG::Persistence)
  end
end