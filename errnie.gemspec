lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "errnie/version"

Gem::Specification.new do |spec|
  spec.name          = "errnie"
  spec.version       = Errnie::VERSION
  spec.authors       = ["Kyle Conarro"]
  spec.email         = ["kyle.conarro@gmail.com"]

  spec.summary       = 'Manually report errors to external error reporting services'
  spec.homepage      = "https://github.com/AdReform/errnie"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "appsignal", "~> 3.0"
  spec.add_development_dependency "bugsnag", "~> 6.0"
end
