# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "googlevoiceapi/version"

Gem::Specification.new do |s|
  s.name        = "googlevoiceapi"
  s.version     = GoogleVoice::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tim Gourley"]
  s.email       = ["tgourley@gmail.com"]
  s.homepage    = "http://github.com/bratta/googlevoiceapi"
  s.summary     = "Ruby library for interacting with Google Voice"
  s.description = "Uses Mechanize to screen-scrape Google Voice since there is no public API"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

  s.add_dependency "mechanize"
  s.add_dependency "htmlentities"

  s.rubyforge_project = "testing"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
