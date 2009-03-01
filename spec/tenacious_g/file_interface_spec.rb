require File.join(File.dirname(__FILE__), "/../spec_helper")

describe FileInterface do
  it "should write files to ~/.tenacious_g/name.graph" do
    FileInterface.write(:test_file)
    File.exist?(File.expand_path('~/.tenacious_g/test_file.graph')).should eql(true)
    `rm ~/.tenacious_g/test_file.graph`
    File.exist?(File.expand_path('~/.tenacious_g/test_file.graph')).should eql(false)
  end
  
  it "should marshal contents" do
    FileInterface.write(:test_file, :contents => "Some Contents")
    Marshal.load(File.read(File.expand_path('~/.tenacious_g/test_file.graph'))).should eql('Some Contents')
    `rm ~/.tenacious_g/test_file.graph`
    File.exist?(File.expand_path('~/.tenacious_g/test_file.graph')).should eql(false)
  end
  
  it "should handle contents from a symbol" do
    FileInterface.write(:test_file, :contents => "Some Contents")
    FileInterface.read(:test_file).should eql("Some Contents")
    `rm ~/.tenacious_g/test_file.graph`
    File.exist?(File.expand_path('~/.tenacious_g/test_file.graph')).should eql(false)
  end
  
  it "should handle contents from a string" do
    FileInterface.write('test_file', :contents => "Some Contents")
    FileInterface.read('test_file').should eql("Some Contents")
    `rm ~/.tenacious_g/test_file.graph`
    File.exist?(File.expand_path('~/.tenacious_g/test_file.graph')).should eql(false)
  end
  
end