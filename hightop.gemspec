require_relative "lib/hightop/version"

Gem::Specification.new do |spec|
  spec.name          = "hightop"
  spec.version       = Hightop::VERSION
  spec.summary       = "A nice shortcut for group count queries"
  spec.homepage      = "https://github.com/ankane/hightop"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3.2"

  spec.add_dependency "activesupport", ">= 7.1"
end
