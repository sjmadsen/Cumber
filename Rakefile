require 'yaml'
require 'erb'
require 'cumber'

desc 'build app'
task :build do
  project = File.expand_path('./Cumber-Test/Cumber-Test.xcodeproj')
  system ('xcodebuild -project '+ project +' -target Cumber-Test -sdk iphoneos -configuration Debug clean build')
end

desc 'Install app to device'
task :install do
  app = File.expand_path('./Cumber-Test/build/Debug-iphoneos/Cumber-Test.app')
  system('appdeploy install -p ' + app)
end

desc 'Uninstall app to device'
task :uninstall do
  system('appdeploy uninstall -b edu.self.Cumber-Test')
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
  Cumber.start_instruments(%x[appdeploy get_udid].strip, 'Cumber-Test')
end

desc 'Start screen inspect'
task :inspect do
  Cumber.start
  Cumber.new_run(%x[appdeploy get_udid].strip, 'Cumber-Test')
  Cumber.inspect
end

