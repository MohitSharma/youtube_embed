# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youtube_embed/version'

Gem::Specification.new do |gem|
  gem.name          = "youtube_embed"
  gem.version       = YoutubeEmbed::VERSION
  gem.authors       = ["Mohit Sharma"]
  gem.email         = ["developer.pht@gmail.com"]
  gem.description   = %q{Embed youtube videos by saving url}
  gem.summary       = %q{Embed youtube videos saving url and show simple iframe embedded or embedded like facebook with thumnail, title and description }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "httparty"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
