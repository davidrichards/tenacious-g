require File.dirname(__FILE__) + '/../spec_helper'

describe Persistence do
  it "should have pstore required from the Standard Library" do
    defined?(PStore).should_not be_nil
  end
  
  it "should make location available" do
    class A
      include Persistence
    end
    a = A.new
    default_location = File.expand_path(File.join(ENV['HOME'], %w(.tenacious_g graph.pstore)))
    
    a.location.should eql(default_location)
    Object.send(:remove_const, :A)
  end
  
  it "should make directory available" do
    class A
      include Persistence
    end
    a = A.new
    default_dir = File.expand_path(File.join(ENV['HOME'], %w(.tenacious_g)))
    
    a.directory.should eql(default_dir)
    a.directory = '/tmp'
    a.directory.should eql('/tmp')
    a.location.should eql('/tmp/graph.pstore')
    Object.send(:remove_const, :A)
  end
  
  it "should make name available" do
    class A
      include Persistence
    end
    a = A.new
    default_name = 'graph'
    default_dir = File.expand_path(File.join(ENV['HOME'], %w(.tenacious_g)))

    a.name.should eql(default_name)
    a.name = 'george'
    a.name.should eql('george')
    a.location.should eql("#{default_dir}/george.pstore")
    Object.send(:remove_const, :A)
  end
  
  it "should use a pstore to store the graph" do
    class A
      include Persistence
    end
    a = A.new
    a.send(:pstore).should be_is_a(PStore)
    Object.send(:remove_const, :A)
  end
  
  it "should be able to save and load itself" do
    class A
      attr_accessor :special_var
      include Persistence
    end
    a = A.new
    a.special_var = 123
    lambda{a.save}.should_not raise_error
    lambda{@a = A.load('graph')}.should_not raise_error
    @a.should be_is_a(A)
    @a.special_var.should eql(123)
    Object.send(:remove_const, :A)
  end
  
end
