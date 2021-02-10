platform :ios, '14.2'
use_frameworks!

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
