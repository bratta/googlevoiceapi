require 'rake'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--format', 'n', '-c']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default  => :spec