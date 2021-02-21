platform :ios, '14.2'
use_frameworks!
inhibit_all_warnings!

### Parameters ###
source 'https://github.com/CocoaPods/Specs.git'

def commom_dependencies
  pod 'SwiftLint', '0.42.0'
  pod 'SwiftGen', '6.4.0'
end

def commom_test_dependencies
  pod 'Quick', '~> 3.1.1'
  pod 'Nimble', '~> 9.0.0'
  pod 'Nimble-Snapshots', '~> 9.0.0'
end

def interface_test_dependencies
  commom_test_dependencies
  pod 'Nimble-Snapshots', '~> 9.0.0'
end

### Application ###
target 'The-Norris' do
  commom_dependencies
  
  target 'The-NorrisTests' do
    inherit! :search_paths
    interface_test_dependencies
  end
end

### Interface ###
target 'Interface' do
  commom_dependencies

  target 'InterfaceTests' do
    inherit! :search_paths
    interface_test_dependencies
  end
end

### Client ###
target 'Client' do
  commom_dependencies

  target 'ClientTests' do
    inherit! :search_paths
    commom_test_dependencies
  end
end

### Configuration ###
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
