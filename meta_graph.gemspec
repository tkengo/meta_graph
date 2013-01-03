Gem::Specification.new do |s|
  s.name        = 'meta_graph'
  s.version     = File.read('VERSION').delete("\n\r")
  s.date        = '2013-01-03'
  s.summary     = 'Meta Graph'
  s.description = 'A lightweight client of Facebook Graph API'
  s.authors     = [ 'Kengo Tateishi' ]
  s.email       = 'embrace.ddd.flake.peace@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage    = 'https://github.com/tkengo/meta_graph'

  s.add_runtime_dependency 'httpclient'
  s.add_runtime_dependency 'rspec'
  s.add_runtime_dependency 'webmock'
end
