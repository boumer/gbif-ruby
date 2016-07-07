Gem::Specification.new do |s|
  s.name        = 'GBIF'
  s.version     = '1.0.pre'
  s.summary     = 'Client for the Global Biodiversity Information Facility (GBIF) API.'
  s.homepage    = 'https://github.com/jshorty/gbif-ruby'
  s.author      = 'Jacob Shorty'
  s.email       = 'jakeshorty@gmail.com'
  s.license     = 'GPL-3.0'
  s.files       = ['/lib/gbif.rb']
  s.add_runtime_dependency('rest-client')
  s.required_ruby_version = '>= 2.0.0'
end
