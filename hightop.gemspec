
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hightop/version"

Gem::Specification.new do |spec|
  spec.name          = "hightop"
  spec.version       = Hightop::VERSION
  spec.summary       = "A nice shortcut for group count queries"
  spec.homepage      = "https://github.com/ankane/hightop"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "sqlite3", "~> 1.3.0"
end
