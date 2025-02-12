#
# Be sure to run `pod lib lint TSAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TSAlertController'
  s.version          = '1.0.0'
  s.summary          = '✨An elegant Alert library written in Swift'

  s.description      = <<-DESC
  TSAlertController is a customizable and user-friendly alert system designed to provide a seamless and modern alternative to UIAlertController. It offers various customization options, including interactive features, animations, and layout configurations, making it easy to integrate into any iOS project. TSAlertController aims to enhance user experience with elegant and flexible alert presentations.
                       DESC

  s.homepage         = 'https://github.com/rlarjsdn3/TSAlertController-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KIM-SOWOL' => 'rlarjsdn3@naver.com' }
  s.source           = { :git => 'https://github.com/rlarjsdn3/TSAlertController-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'

  s.source_files = 'TSAlertController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TSAlertController' => ['TSAlertController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
