Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'sampras'
  s.version = '0.0.1'
  s.summary = 'Faux API Framework'
  s.description = 'Sampras is a framework for developing faux APIs.'

  s.author = 'Christopher Rankin'
  s.email = 'rankin.devon@gmail.com'
  s.homepage = ''

  # Not in a very distant future
  # s.required_ruby_version = '>=1.9.2'

  s.add_dependency('activesupport',   '~> 3.2.13')
  s.add_dependency('rack',            '~> 1.5.2')
  s.add_dependency('thor',            '~> 0.17.0')
  s.add_dependency('commander',       '~> 4.1.3')

  s.files = Dir['README', 'MIT-LICENSE', 'lib/**/*', 'bin/**/*']
  s.has_rdoc = false

  s.require_path = 'lib'

  s.bindir = 'bin'
  s.executables = ['sampras']
end
