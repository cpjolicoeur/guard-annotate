require 'spec_helper'

describe Guard::Annotate do
  subject { Guard::Annotate.new }
  
  context "#initialize options" do
    describe "notify" do
      it "should be true by default" do
        subject.should be_notify
      end
      
      it "should be able to be set to false" do
        subject = Guard::Annotate.new( [], :notify => false )
        subject.options[:notify].should be_false
      end
    end
  end
  
  context "start" do
  end
  
  context "stop" do
  end
  
  context "reload" do
  end
  
  context "run_on_change" do
  end
end