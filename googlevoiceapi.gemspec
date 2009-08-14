# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{googlevoiceapi}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Gourley"]
  s.date = %q{2009-08-13}
  s.description = %q{Ruby library for interacting with Google Voice}
  s.email = %q{tgourley@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/googlevoiceapi.rb", "LICENSE", "README.rdoc", "tasks/rspec.rake"]
  s.files = ["CHANGELOG", "lib/googlevoiceapi.rb", "LICENSE", "Manifest", "Rakefile", "README.rdoc", "spec/example.rspec_config.yml", "spec/googlevoiceapi_spec.rb", "spec/README", "spec/rspec_config.yml", "spec/spec_helper.rb", "tasks/rspec.rake", "googlevoiceapi.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bratta/googlevoiceapi}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Googlevoiceapi", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{googlevoiceapi}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby library for interacting with Google Voice}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<htmlentities>, [">= 0"])
      s.add_runtime_dependency(%q<mechanize>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<htmlentities>, [">= 0"])
      s.add_dependency(%q<mechanize>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<htmlentities>, [">= 0"])
    s.add_dependency(%q<mechanize>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
