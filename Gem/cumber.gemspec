Gem::Specification.new do |gem|
  gem.name = 'cumber'
  gem.version = '0.0.1'
  gem.authors = ['Chip Snyder']
  gem.email = ['chip.snyder3@gmail.com']
  gem.description = 'UIAutomation tool that bridges the gap between cucumber tests and XCode Instruments'
  gem.summary = 'UIAutomation tool that bridges the gap between cucumber tests and iOS XCode Instruments'
  gem.homepage = 'https://github.com/chipsnyder/Cumbermation'
  gem.files = ['lib/cumber.rb']
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'socket'
  gem.add_development_dependency 'uri'
  gem.add_development_dependency 'net/http'
end