# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tenacious_g}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Richards"]
  s.date = %q{2009-02-25}
  s.description = %q{TODO}
  s.email = %q{davidlamontrichards@gmail.com}
  s.files = ["lib/tenacious_g", "lib/tenacious_g/overrides", "lib/tenacious_g/overrides/file.rb", "lib/tenacious_g/overrides/module.rb", "lib/tenacious_g/persistence.rb", "lib/tenacious_g/tainting_methods.rb", "lib/tenacious_g.rb", "spec/spec_helper.rb", "spec/tenacious_g", "spec/tenacious_g/overrides", "spec/tenacious_g/overrides/file_spec.rb", "spec/tenacious_g/overrides/module_spec.rb", "spec/tenacious_g/persistence_spec.rb", "spec/tenacious_g_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/davidrichards/tenacious_g}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
