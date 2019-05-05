$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dynamic_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dynamic_search"
  s.version     = DynamicSearch::VERSION
  s.authors     = ["Jeremy Winterberg"]
  s.email       = ["winterjd@uwec.edu"]
  s.homepage    = "https://www.github.com/jeremydwayne/dynamic_search"
  s.summary     = "DynamicSearch provides support for multi term searches to your rails models."
  s.description = "Adds a search method which allows you to search for multiple words from multiple columns."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
