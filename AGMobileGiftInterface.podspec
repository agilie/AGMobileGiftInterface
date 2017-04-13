#
# Be sure to run `pod lib lint AGMobileGiftInterface.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AGMobileGiftInterface'
  s.version          = '0.1.0'
  s.platform         = :ios, '8.0'
  s.summary          = 'A short description of AGMobileGiftInterface.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/agilie/AGMobileGiftInterface'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Agilie' => 'info@agilie.com' }
  s.source           = { :git => 'https://github.com/agilie/AGMobileGiftInterface.git', :tag => '0.1.0' }

  s.ios.deployment_target = '8.0'

  s.source_files = 'AGMobileGiftInterface/Classes/**/*.{swift}'
  
  # s.resource_bundles = {
  #   'AGMobileGiftInterface' => ['AGMobileGiftInterface/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'ImageIO'
end
