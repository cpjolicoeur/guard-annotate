# encoding: utf-8
require 'guard'
require 'guard/guard'

module Guard
  class Annotate < Guard
    
    autoload :Notifier, 'guard/annotate/notifier'
    
    def initialize( watchers=[], options={} )
      super
      
      options[:notify] = true if options[:notify].nil?
    end

    def start
      run_annotate
    end

    def stop
      true
    end

    def reload
      run_annotate
    end

    def run_all
      run_annotate
    end

    def run_on_change( paths=[] )
      run_annotate
    end
    
    private
    
    def notify?
      !!options[:notify]
    end
    
    def run_annotate
      UI.info 'Running annotate', :reset => true
      start_at = Time.now
      @result = system('annotate')
      Notifier::notify( @result, Time.now - started_at ) if notify?
      @result
    end
  end
end
