require 'yaml'
require 'erb'
require 'cumber'

desc 'build app'
task :build do
  config = YAML.load(ERB.new(File.read('config.yml')).result)
  system ('xcodebuild -project '+ config['project'] +' -target '+ config['target'] +' -sdk iphoneos -configuration Debug clean build')
end

desc 'Install app to device'
task :install do
  config = YAML.load(ERB.new(File.read('config.yml')).result)
  system('appdeploy install ' + config['app'])
end

desc 'Uninstall app to device'
task :uninstall do
  config = YAML.load(ERB.new(File.read('config.yml')).result)
  system('appdeploy uninstall ' + config['bundle'])
end

desc 'Deploy app to device'
task :deploy => [:uninstall, :build, :install]

desc 'ReDeploy the app to device with out building'
task :rerun => [:uninstall, :install]

desc 'Run Cukes'
task :test => [:deploy]

desc 'Turn verbose logging on'
task :turn_on_verbose_logging do
  `defaults delete com.apple.dt.InstrumentsCLI UIAVerboseLogging`
end

desc 'Turn verbose logging off'
task :turn_off_verbose_logging do
  `defaults write com.apple.dt.InstrumentsCLI UIAVerboseLogging -int 4096`
end

desc 'Start Server'
task :launch do
  CumberServer.start
  #Cumber.start
end

