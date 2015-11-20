# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "motion-authorization"
  spec.version       = "1.0.0"
  spec.authors       = ["Andrew Havens"]
  spec.email         = ["email@andrewhavens.com"]

  spec.summary       = %q{Simple authorization for RubyMotion. Inspired by CanCan and Pundit.}
  spec.homepage      = "https://github.com/andrewhavens/motion-authorization"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
end
