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

  #s.add_development_dependency "mysql2"
end
