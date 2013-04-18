# encoding: utf-8
require 'guard'
require 'guard/guard'
require 'guard/version'

module Guard
  class Annotate < Guard

    autoload :Notifier, 'guard/annotate/notifier'

    def initialize(watchers=[], options={})
      super

      options[:notify] = true if options[:notify].nil?
      options[:position] = 'before' if options[:position].nil?
      options[:tests] = false if options[:tests].nil?
      options[:routes] = false if options[:routes].nil?
      options[:run_at_start] = true if options[:run_at_start].nil?
      options[:show_indexes] = false if options[:show_indexes].nil?
      options[:simple_indexes] = false if options[:simple_indexes].nil?
      options[:show_migration] = false if options[:show_migration].nil?
      options[:format] = nil if options[:format].nil? or not [:bare, :markdown, :rdoc].include? options[:format].to_sym
    end

    def start
      run_annotate if options[:run_at_start]
    end

    def stop
      true
    end

    def reload
      run_annotate if options[:run_at_start]
    end

    def run_all
      true
    end

    def run_on_changes(paths=[])
      run_annotate
    end
    alias :run_on_change :run_on_changes if VERSION < '1.1.0'

    private

    def notify?
      !!options[:notify]
    end

    def annotation_position
      options[:position]
    end

    def annotate_routes?
      options[:routes]
    end

    def annotate_tests_flags
      options[:tests] ? '' : '--exclude tests,fixtures'
    end

    def show_indexes?
      options[:show_indexes]
    end

    def annotate_format
      options[:format]
    end

    def annotate_format?
      not options[:format].nil?
    end

    def simple_indexes?
      options[:simple_indexes]
    end

    def show_migration?
      options[:show_migration]
    end

    def run_annotate
      UI.info 'Running annotate', :reset => true
      started_at = Time.now
      annotate_models_options, annotate_options = '', ''

      annotate_models_command = "bundle exec annotate #{annotate_tests_flags} -p #{annotation_position}"
      annotate_models_options += ' --show-indexes' if show_indexes?
      annotate_models_options += ' --simple-indexes' if simple_indexes?
      annotate_models_options += ' --show-migration' if show_migration?
      annotate_options += " --format=#{annotate_format}" if annotate_format?

      annotate_models_command += annotate_models_options + annotate_options
      @result = system(annotate_models_command)
      Notifier::notify(@result, Time.now - started_at) if notify?

      if annotate_routes?
        started_at = Time.now
        annotate_routes_command = "bundle exec annotate -r -p #{annotation_position}"

        annotate_routes_command += annotate_options
        @result = system(annotate_routes_command)
        Notifier::notify(@result, Time.now - started_at) if notify?
      end

      @result
    end
  end
end
