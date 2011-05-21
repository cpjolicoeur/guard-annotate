require 'rspec'
require 'guard/annotate'

Dir["#{File.expand_path('..', __FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |c|
  c.color_enabled = true
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
  
  c.before( :each ) do
    ENV["GUARD_ENV"] = "test"
    ::Guard::Notifier.stub( :notify ).and_return( true )
    @lib_path = Pathname.new( File.expand_path( '../../lib/', __FILE__ ) )
  end
  
  c.after( :each ) do
    ENV["GUARD_ENV"] = nil
  end
end