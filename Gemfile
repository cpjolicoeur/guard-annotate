source "http://rubygems.org"

# Specify your gem's dependencies in guard-annotate.gemspec
gemspec

require './spec/support/platform_helper'

if mac?
  gem 'rb-fsevent', '>= 0.3.2'
  gem 'growl',      '~> 1.0.3'
elsif linux?
  gem 'rb-inotify', '>= 0.5.1'
  gem 'libnotify',  '~> 0.1.3'
end
