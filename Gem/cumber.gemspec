Gem::Specification.new do |gem|
  gem.name = 'cumber'
  gem.version = '1.0.6'
  gem.licenses    = ['MIT']
  gem.authors = ['Chip Snyder']
  gem.email = ['chip.snyder3@gmail.com']
  gem.description = 'UIAutomation tool that bridges the gap between cucumber tests and XCode Instruments'
  gem.summary = 'UIAutomation tool that bridges the gap between cucumber tests and iOS XCode Instruments'
  gem.homepage = 'https://github.com/chipsnyder/Cumber'

  gem.files = Dir.glob('{lib,doc}/**/**/*')

  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'yard', '~> 0.8'

end