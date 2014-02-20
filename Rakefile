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
  system('appdeploy install -p ' + config['app'])
end

desc 'Uninstall app to device'
task :uninstall do
  config = YAML.load(ERB.new(File.read('config.yml')).result)
  system('appdeploy uninstall -b ' + config['bundle'])
end

desc 'Deploy app to device'
task :deploy => [:uninstall, :build, :install]

desc 'ReDeploy the app to device with out building'
task :rerun => [:uninstall, :install]

desc 'Run Cukes'
task :test => [:deploy]

desc 'Turn verbose logging on'
task :logs_on do
  `defaults delete com.apple.dt.InstrumentsCLI UIAVerboseLogging`
end

desc 'Turn verbose logging off'
task :logs_off do
  `defaults write com.apple.dt.InstrumentsCLI UIAVerboseLogging -int 4096`
end

desc 'Start up a debug session'
task :debug do
  Cumber.stop_server
  CumberServer.start true
end

desc 'Start instruments'
task :instruments do
  Cumber.start_instruments(%x[appdeploy get_udid], 'Cumber-Test')
end

