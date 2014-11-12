# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/annotate/version"

Gem::Specification.new do |s|
  s.name        = "guard-annotate"
  s.version     = Guard::AnnotateVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Craig P Jolicoeur"]
  s.email       = ["cpjolicoeur@gmail.com"]
  s.homepage    = "http://craigjolicoeur.com"
  s.summary     = %q{Guard gem for annotate}
  s.description = %q{Guard::Annotate automatically runs the annotate gem when needed}
  s.license     = "MIT"

  s.rubyforge_project = "guard-annotate"

  s.add_dependency 'guard', '~> 2.0'
  s.add_dependency 'annotate', '~> 2.4', '>= 2.4.0'

  s.add_development_dependency 'rspec', '~> 2.9.0'
  s.add_development_dependency 'guard-rspec', '~> 0.6.0'
  s.add_development_dependency 'rake', '~> 0.9.2.2'

  s.files = Dir.glob('{lib}/**/*') + %w[LICENSE README.rdoc]
  s.require_paths = ["lib"]

  s.rdoc_options = ["--charset=UTF-8", "--main=README.rdoc", "--exclude='(lib|test|spec)|(Gem|Guard|Rake)file'"]
end
