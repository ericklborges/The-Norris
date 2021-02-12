platform :ios, '14.2'
use_frameworks!
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

def test_dependencies
	pod 'Quick', '~> 3.1.1'
    pod 'Nimble', '~> 9.0.0'
    pod 'Nimble-Snapshots', '~> 9.0.0'
end

target 'The-Norris' do
  pod 'SwiftLint', '0.42.0'
  
  target 'The-NorrisTests' do
    inherit! :search_paths
    test_dependencies
  end
end

target 'InterfaceTests' do
  test_dependencies
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
