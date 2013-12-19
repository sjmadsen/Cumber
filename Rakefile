require 'yaml'
require 'erb'

desc 'build app'
task :build do
	config = YAML.load(ERB.new(File.read('config.yml')).result)
	system ('xcodebuild -project '+ config['project'] +' -target '+ config['target'] +' -sdk iphoneos -configuration Debug clean build')
end

desc 'launch app on device'
task :launch do
  config = YAML.load(ERB.new(File.read('config.yml')).result)
	system ('instruments -w '+ config['udid'] +' -D ./bin/ins.trace -t /Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate '+ config['target'] +' -e UIASCRIPT ./driver/driver.js')
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
task :deploy => [:uninstall, :build, :install, :launch]

desc 'ReDeploy the app to device with out building'
task :rerun => [:uninstall, :install, :launch]
