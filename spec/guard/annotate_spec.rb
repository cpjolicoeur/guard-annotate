require 'spec_helper'

describe Guard::Annotate do
  subject { Guard::Annotate.new }

  context "#initialize options" do
    describe "notify" do
      it "should be true by default" do
        subject.should be_notify
      end

      it "should allow notifications to be turned off" do
        subject = Guard::Annotate.new( [], :notify => false )
        subject.options[:notify].should be_false
      end
    end

    describe "position" do
      it "should use 'before' position by default" do
        subject.options[:position].should == 'before'
      end

      it "should allow user to customize position (before)" do
        subject = Guard::Annotate.new( [], :position => 'before' )
        subject.options[:position].should == 'before'
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
        subject.start
      end

      it "should allow user to customize position (after)" do
        subject = Guard::Annotate.new( [], :position => 'after' )
        subject.options[:position].should == 'after'
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p after")
        subject.start
      end
    end

    describe "routes" do
      it "should not run routes by default" do
        subject.options[:routes].should be_false
      end

      it "should allow the users to run routes if desired" do
        subject = Guard::Annotate.new( [], :routes => true)
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
        subject.should_receive(:system).with("bundle exec annotate -r -p before")
        subject.start
      end

      it "should allow the user to customize routes annotation position (before)" do
        subject = Guard::Annotate.new( [], :routes => true, :position => 'before')
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
        subject.should_receive(:system).with("bundle exec annotate -r -p before")
        subject.start
      end

      it "should allow the user to customize routes annotation position (after)" do
        subject = Guard::Annotate.new( [], :routes => true, :position => 'after')
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p after")
        subject.should_receive(:system).with("bundle exec annotate -r -p after")
        subject.start
      end
    end

    describe "tests & fixtures" do
      it "should not run tests annotations by default" do
        subject.options[:tests].should be_false
      end

      it "should allow user to run tests and fixtures annotations if desired" do
        subject = Guard::Annotate.new( [], :tests => true )
        subject.should_receive(:system).with("bundle exec annotate  -p before")
        subject.start
      end
    end
    
    describe "sort columns by name" do
      it "should not sort columns by name by default" do
        subject.options[:sort].should be_false
      end

      it "should allow user to sort columns by name if desired" do
        subject = Guard::Annotate.new( [], :sort => true )
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --sort")
        subject.start
      end
    end

    describe "indexes" do
      it "should not add indexes to annotations by default" do
        subject.options[:show_indexes].should be_false
      end

      it "should allow user to add indexes to annotations if desired" do
        subject = Guard::Annotate.new( [], :show_indexes => true )
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --show-indexes")
        subject.start
      end
    end

    describe "simple indexes" do
      it "should not add simple indexes to annotations by default" do
        subject.options[:simple_indexes].should be_false
      end

      it "should allow user to add simple indexes to annotations if desired" do
        subject = Guard::Annotate.new( [], :simple_indexes => true )
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --simple-indexes")
        subject.start
      end
    end

    describe "show migration" do
      it "should not show migration version in annotations by default" do
        subject.options[:show_migration].should be_false
      end

      it "should allow user to add migration version in annotations if desired" do
        subject = Guard::Annotate.new( [], :show_migration => true )
        subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --show-migration")
        subject.start
      end
    end

    describe "annotation format" do
      it "should not add format type to annotations by default" do
        subject.options[:show_migration].should be_false
      end

      describe "invalid" do
        it "should not add format type if option given is invalid" do
          subject = Guard::Annotate.new( [], :format => :invalid_option)
          subject.options[:show_migration].should be_false
          subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
          subject.start
        end
      end
      describe "bare" do
        it "should allow user to choose format of annotations if desired" do
          subject = Guard::Annotate.new( [], :format => :bare )
          subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --format=bare")
          subject.start
        end
      end
      describe "rdoc" do
        it "should allow user to choose format of annotations if desired" do
          subject = Guard::Annotate.new( [], :format => :rdoc )
          subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --format=rdoc")
          subject.start
        end
      end
      describe "markdown" do
        it "should allow user to choose format of annotations if desired" do
          subject = Guard::Annotate.new( [], :format => :markdown )
          subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before --format=markdown")
          subject.start
        end
      end
    end
    
    describe "run_at_start" do
      it "should run at start by default" do
        subject.options[:run_at_start].should be_true
      end

      it "should allow user to opt out of running at start" do
        subject = Guard::Annotate.new( [], :run_at_start => false)
        subject.options[:run_at_start].should be_false
      end
    end
  end

  context "start" do
    it "should run annotate command" do
      subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
      subject.start
    end

    it "should return false if annotate command fails" do
      subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before").and_return(false)
      subject.start.should be_false
    end

    it 'should not run annotate command if disabled :run_at_start' do
      subject.should_not_receive(:system)
      subject.options[:run_at_start] = false
      subject.start
    end
  end

  context "stop" do
    it "should be a noop (return true)" do
      subject.stop.should be_true
    end
  end

  context "reload" do
    it "should run annotate command" do
      subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
      subject.reload
    end

    it "should return false if annotate command fails" do
      subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before").and_return(false)
      subject.reload.should be_false
    end

    it 'should not run annotate command if disabled :run_at_start' do
      subject.should_not_receive(:system)
      subject.options[:run_at_start] = false
      subject.reload
    end
  end

  context "run_all" do
    it "should be a noop (return true)" do
      subject.run_all.should be_true
    end
  end

  # For Guard 1.1. #run_on_change is deprecated
  context "run_on_changes" do
    it "should run annotate command" do
      subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before")
      subject.run_on_changes
    end

    it "should return false if annotate command fails" do
      subject.should_receive(:system).with("bundle exec annotate --exclude tests,fixtures -p before").and_return(false)
      subject.run_on_changes.should be_false
    end
  end
end
