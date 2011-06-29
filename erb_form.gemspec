# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "erb_form/version"

Gem::Specification.new do |s|
  s.name        = "erb_form"
  s.version     = ErbForm::VERSION
  s.authors     = ["Benjamin Lewis"]
  s.email       = ["23inhouse@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ERB templated forms}
  s.description = %q{Wrap form helper methods in re-usable erb templates.}

  s.rubyforge_project = "erb_form"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
