require 'guard'
require 'guard/guard'

module Guard
  class Annotate < Guard

    def initialize( watchers=[], options={} )
      super
    end

    def start
      true
    end

    def stop
      true
    end

    def reload
      true
    end

    def run_all
      true
    end

    def run_on_change( paths )
      true
    end
  end
end
