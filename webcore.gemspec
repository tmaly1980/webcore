$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "webcore/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webcore"
  s.version     = "1.0.0" #Webcore::VERSION
  s.authors     = ["Tomas Maly"]
  s.email       = ["tmaly1980@gmail.com"]
  s.homepage    = "http://hopefulpress.com/"
  s.summary     = "Core web helpers and assets"
  s.description = "Basic CSS, javascript, and helper tools"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  #s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

s.add_dependency 'publishable'
s.add_dependency 'get_or_build' # fixes not needing to 'build' associations for fields_for
s.add_dependency 'acts_as_singleton'
s.add_dependency "paperclip", "~> 5.0.0"
s.add_dependency 'devise'
s.add_dependency 'omniauth-facebook'
s.add_dependency 'bootstrap-sass', '~> 3.3.6'
s.add_dependency 'font-awesome-sass', '~> 4.6.2'
s.add_dependency 'jquery-ui-rails'
s.add_dependency 'kaminari' # paginate
s.add_dependency 'therubyracer'
s.add_dependency 'less', '~> 2.6'
s.add_dependency 'redactor-rails', '~> 0.5.0'
s.add_dependency "mini_magick"
s.add_dependency "bootstrap_form"
s.add_dependency 'cancancan'
s.add_dependency 'acts_as_list' # Sortable
#s.add_dependency 'passenger' # apache proxy
s.add_dependency 'simple_form'

  #s.add_development_dependency "mysql2"
end
