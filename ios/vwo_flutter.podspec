#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint vwo_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'vwo_flutter'
  s.version          = '0.1.0'
  s.summary          = 'VWO SDK for A/B Testing Flutter apps.'
  s.description      = <<-DESC
 VWO Flutter plugin allows you to A/B Test your Mobile Applications.
                       DESC
  s.homepage         = 'http://vwo.com'
  s.license          = { :type => 'Commercial', :text => 'See http://vwo.com/terms-conditions' }
  s.author           = { 'VWO' => 'info@wingify.com' }
  s.source           = { :git => "https://github.com/wingify/vwo-flutter-sdk" }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'VWO', '~> 2.7.1'
  s.platform = :ios, '9.0'
  #s.preserve_paths = 'VWO.framework'
  #s.xcconfig = { 'OTHER_LDFLAGS' => '-framework VWO' }
  #s.vendored_frameworks = 'VWO.framework'
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
end