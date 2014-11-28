#
# Be sure to run `pod lib lint FeedbackMe.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FeedbackMe"
  s.version          = "0.1.0"
  s.summary          = "Ask for user reviews and feedback with ease"
  s.description      = <<-DESC
Asking for feedback when user is launching your app **IS NOT THE BEST TIME** goddammit.

You **don't have to create any account** to use this pod,
But if you want to use our feedback manager tool, go to [our website](http://feedbackme.herokuapp.com).

The feedback manager tool is free for the first month, after that it cost only $1/month per app.
                       DESC
  s.homepage         = "https://github.com/leonardoobaptistaa/FeedbackMe"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Leonardo Baptista" => "leonardoobaptistaa@gmail.com" }
  s.source           = { :git => "https://github.com/leonardoobaptistaa/FeedbackMe.git", :tag => '0.1.0' }
  s.social_media_url = 'https://twitter.com/leonardocbs'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'FeedbackMe' => ['Pod/Assets/*.png', 'Pod/Assets/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
