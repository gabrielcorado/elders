require './lib/elders/version'

Gem::Specification.new do |s|
  s.name = 'elders'
  s.version = Elders.version

  s.summary = ''
  s.description = ''

  s.author = 'Gabriel Corado'
  s.email = 'gabrielcorado@mail.com'
  s.homepage = 'http://github.com/gabrielcorado/elders'

  s.files = `git ls-files`.strip.split("\n")
  s.executables = Dir["bin/*"].map { |f| File.basename(f) }

  # Dependencies
  s.add_dependency 'concurrent-ruby', '~> 1.0.0'
  s.add_dependency 'docker-api', '~> 1.26.0'
  s.add_dependency 'json'

  # Development depencies
  s.add_development_dependency 'rspec', '~> 3.0.0'
  # s.add_dependency 'open4', '~> 1.3.4'
end
