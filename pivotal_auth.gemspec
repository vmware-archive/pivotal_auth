$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'pivotal_auth/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pivotal_auth'
  s.version     = PivotalAuth::VERSION
  s.authors     = ['Alex Choi', 'Molly Trombley-McCann']
  s.email       = %w(achoi@pivotal.io mtrombleymccann@pivotal.io)
  s.homepage    = 'https://github.com/pivotal/pivotal_auth'
  s.summary     = 'Authentication gem for Pivotal Labs.'
  s.description = ''

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 3.2.0'
  s.add_dependency 'pivotal-sass'
  s.add_dependency 'compass-rails'
  s.add_dependency 'omniauth-saml'
  s.add_dependency 'omniauth-google-oauth2'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
end
