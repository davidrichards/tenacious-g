require File.join(File.dirname(__FILE__), "/../../spec_helper")

describe Module do
  it "should have alias_method_chain" do
    class A
      def go
        'go'
      end
      def go_with_flair
        go_without_flair + " flair"
      end
      alias_method_chain :go, :flair
    end
    a = A.new
    a.go.should eql('go flair')
    a.go_without_flair.should eql('go')
    Object.send(:remove_const, :A)
  end
  
  it "should have archive_method" do
    class A
      archive_method(:go)
    end
    a = A.new
    a.methods.should_not be_include('go')
    a.methods.should be_include('original_go')
    a.original_go.should be_nil

    class A
      def go
        'go'
      end
      archive_method(:go)
      def go
        'a new go'
      end
    end
    a = A.new
    a.methods.should be_include('go')
    a.methods.should be_include('original_go')
    a.go.should eql('a new go')
    a.original_go.should eql('go')
    Object.send(:remove_const, :A)

    class A
      def go
        'go'
      end
      archive_method(:go, :prefix => :different_name_)
    end
    a = A.new
    a.methods.should_not be_include('go')
    a.methods.should be_include('different_name_go')
    a.different_name_go.should eql('go')
    Object.send(:remove_const, :A)

  end
  
end