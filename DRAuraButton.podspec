#
# Be sure to run `pod lib lint DRAuraButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DRAuraButton'
  s.version          = '0.2.0'
  s.summary          = 'A UIButton with a rotating subview.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An UIButton with a rotating subview. This subview displays two arc of a circle that can be customized. Customisation can be pre-registered and transitionned between.

Customization includes the color and width of the arcs, the distance between the arcs and the distance between the circle and the button itself.

The UIButton itself appears as a circle (by setting the UIButton.layer.cornerRadius).

The main objective of that pod was to work with the Core Animation framework.
                       DESC

  s.homepage         = 'https://github.com/DeRunco/DRAuraButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Charles Thierry' => 'charles.thierry@gmail.com' }
  s.source           = { :git => 'https://github.com/DeRunco/DRAuraButton.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.1'

  s.source_files = 'DRAuraButton/Classes/**/*'

  s.public_header_files = 'DRAuraButton/Classes/*.h'

end
