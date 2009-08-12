require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('mactts', '0.1.0') do |p|
  p.description    = "Ruby library for interacting with Google Voice"
  p.url            = "http://github.com/bratta/googlevoiceapi"
  p.author         = "Tim Gourley"
  p.email          = "tgourley@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.runtime_dependencies = ['htmlentities', 'mechanize']
  p.development_dependencies = ['rake', 'rspec', 'echoe']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

