source 'https://github.com/CocoaPods/Specs.git'
plugin 'cocoapods-binary-cache'

inhibit_all_warnings!
use_frameworks!

platform :ios, '12.0'

# Rx
pod 'RxSwift', binary: true
pod 'RxCocoa', binary: true
pod 'RxDataSources', binary: true
pod 'RxGesture', binary: true
pod 'RxKeyboard', binary: true

# Architecture
pod 'ReactorKit', binary: true

# Navigation
pod 'RxFlow', binary: true

# DI
pod 'Pure', binary: true

# UI
pod 'SnapKit', binary: true

# Resources
pod 'R.swift', binary: true

# Code Quality
# pod 'SwiftLint', binary: true

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

config_cocoapods_binary_cache(
  cache_repo: {
    'default' => {
      'local' => '~/.cocoapods-binary-cache/photo-searcher/prebuilt-frameworks'
    }
  },
  prebuild_config: 'Debug'
)
