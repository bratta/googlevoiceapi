require "rubygems"
require "bundler"

Bundler.setup

require "yaml"
require "ostruct"

$LOAD_PATH << File.expand_path(File.join('..', 'lib'), File.dirname(__FILE__))

::GVConfig = OpenStruct.new(YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__))}/rspec_config.yml")))
