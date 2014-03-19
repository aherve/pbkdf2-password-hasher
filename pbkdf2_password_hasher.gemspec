# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pbkdf2_password_hasher/version'

Gem::Specification.new do |spec|
  spec.name          = "pbkdf2_password_hasher"
  spec.version       = Pbkdf2PasswordHasher::VERSION
  spec.authors       = ["Aurélien Hervé"]
  spec.email         = ["mail@aurelien-herve.com"]
  spec.summary       = %q{pbkdf2 hash check}
  spec.description   = %q{Check a password against a pbkdf2 hashed string. Useful to import password hashes from django application to rails/devise application}
  spec.homepage      = "https://github.com/aherve/pbkdf2-password-hasher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency  "digest"
end
