# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{contrails}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Cowlishaw"]
  s.date = %q{2011-08-19}
  s.email = %q{tim@timcowlishaw.co.uk}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["Gemfile.lock", "Rakefile", "README.markdown", "Gemfile", "spec/utils_spec.rb", "spec/spec_helper.rb", "spec/process_spec.rb", "lib/contrails/process.rb", "lib/contrails/chainable.rb", "lib/contrails/parallel.rb", "lib/contrails/utils.rb", "lib/contrails/semaphore.rb", "lib/contrails/helpers.rb", "lib/contrails.rb"]
  s.homepage = %q{http://github.com/likely/contrails}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Declarative concurrency for EventMachine}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
