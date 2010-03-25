require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "googlevoiceapi"
    gemspec.summary = "Ruby library for interacting with Google Voice"
    gemspec.description = "Uses Mechanize to screen scrape Google Voice since there is no public API"
    gemspec.email = "tgourley@gmail.com"
    gemspec.homepage = "http://github.com/bratta/googlevoiceapi"
    gemspec.authors = ["Tim Gourley"]
    gemspec.add_dependency('htmlentities')
    gemspec.add_dependency('mechanize')
    gemspec.add_development_dependency('rake')
    gemspec.add_development_dependency('rspec')    
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end