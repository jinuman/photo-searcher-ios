source 'https://github.com/CocoaPods/Specs.git'
plugin 'cocoapods-binary-cache'

inhibit_all_warnings!
use_frameworks!

platform :ios, '11.0'

# Rx
pod 'RxSwift', binary: true
pod 'RxCocoa', binary: true
pod 'RxDataSources', binary: true
pod 'RxGesture', binary: true
pod 'RxKeyboard', binary: true

# Architecture
pod 'ReactorKit', binary: true

# DI
pod 'Pure', binary: true
pod 'Swinject', binary: true
pod 'PureSwinject', binary: true

# UI
pod 'SnapKit', binary: true
pod 'ColorCompatibility', binary: true

# Networking
pod 'Moya/RxSwift', '~> 14', binary: true
pod 'MoyaSugar/RxSwift', binary: true

# Resources
pod 'R.swift', binary: true

# Convenience
pod 'Then', binary: true

def testable_target(name)
  target name do
    yield if block_given?
  end

  target "#{name}Tests" do
    pod 'Quick', binary: true
    pod 'Nimble', binary: true
    pod 'RxTest', binary: true
  end
end

testable_target 'PhotoSearcher'
testable_target 'PhotoSearcherFoundation'
testable_target 'PhotoSearcherUI'
testable_target 'PhotoSearcherNetworking'
testable_target 'PhotoSearcherReactive'
testable_target 'PhotoSearcherTest' do
  pod 'Quick', binary: true
  pod 'Nimble', binary: true
  pod 'RxTest', binary: true
end

config_cocoapods_binary_cache(
  cache_repo: {
    'default' => {
      'local' => '~/.cocoapods-binary-cache/photo-searcher/prebuilt-frameworks'
    }
  },
  prebuild_config: 'Debug'
)

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |build_config|
      build_config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'

      if build_config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
        build_config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
