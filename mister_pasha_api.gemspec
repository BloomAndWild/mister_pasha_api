
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mister_pasha_api/version"

Gem::Specification.new do |spec|
  spec.name          = "mister_pasha_api"
  spec.version       = MisterPashaApi::VERSION
  spec.authors       = ["Bloom and Wild"]
  spec.email         = ["dev@bloomandwild.com"]

  spec.summary       = %q{ruby wrapper for Mister Pasha API}
  spec.description   = %q{ruby wrapper for Mister Pasha API}
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv-rails", "2.7.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock", "3.5.1"
  spec.add_development_dependency "vcr", "~> 4.0"
end
