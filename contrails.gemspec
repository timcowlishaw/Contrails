# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{contrails}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Tim Cowlishaw}]
  s.date = %q{2011-08-25}
  s.email = %q{tim@timcowlishaw.co.uk}
  s.extra_rdoc_files = [%q{README.markdown}]
  s.files = [%q{Gemfile.lock}, %q{Rakefile}, %q{README.markdown}, %q{Gemfile}, %q{spec/utils_spec.rb}, %q{spec/spec_helper.rb}, %q{spec/process_spec.rb}, %q{lib/contrails/process.rb}, %q{lib/contrails/chainable.rb}, %q{lib/contrails/parallel.rb}, %q{lib/contrails/serial.rb}, %q{lib/contrails/utils.rb}, %q{lib/contrails/semaphore.rb}, %q{lib/contrails/helpers.rb}, %q{lib/contrails.rb}]
  s.homepage = %q{http://github.com/likely/contrails}
  s.rdoc_options = [%q{--main}, %q{README.markdown}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
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
