#
# Be sure to run `pod lib lint CVLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CVLib'
  s.version          = '0.1.1'
  s.summary          = 'Mobile computer vision library for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
"CVLib is designed to integrate some advanced computer vision algorithms into mobile phones with ease. This library is created for rapid prototyping and testing production computer vision algorithms with as limited engineering hassles as possible."
                       DESC

  s.homepage         = 'https://github.com/r4ghu/CVLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'r4ghu' => 'm.sriraghu@gmail.com' }
  s.source           = { :git => 'https://github.com/r4ghu/CVLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'CVLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CVLib' => ['CVLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
