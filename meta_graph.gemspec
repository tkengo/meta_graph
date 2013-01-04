Gem::Specification.new do |s|
  s.name        = 'meta_graph'
  s.version     = File.read('VERSION').delete("\n\r")
  s.summary     = 'Meta Graph'
  s.description = 'A lightweight client of Facebook Graph API'
  s.authors     = [ 'Kengo Tateishi' ]
  s.email       = 'embrace.ddd.flake.peace@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {spec}/*`.split("\n")
  s.homepage    = 'https://github.com/tkengo/meta_graph'

  s.add_runtime_dependency 'httpclient'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
end
