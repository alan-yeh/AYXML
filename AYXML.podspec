#
# Be sure to run `pod lib lint AYXML.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AYXML'
  s.version          = '1.0.0'
  s.summary          = 'Simple framework to access XML.'

  s.homepage         = 'https://github.com/alan-yeh/AYXML'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alan Yeh' => 'alan@yerl.cn' }
  s.source           = { :git => 'https://github.com/alan-yeh/AYXML.git', :tag => s.version.to_s }

  s.ios.deployment_target = '6.0'

  s.source_files = 'AYXML/Classes/**/*'
end
