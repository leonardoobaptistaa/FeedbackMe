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
  s.version          = "1.0.1"
  s.summary          = "Ask for user reviews and feedback with ease"
  s.description      = <<-DESC
Asking for feedback when user is launching your app **IS NOT THE BEST TIME** goddammit.

You **don't have to create any account** to use this pod,
But if you want to use our feedback manager tool, go to [our website](http://feedbackme.herokuapp.com).

The feedback manager tool is free if you receive less than 50 feedbacks. Check [our website](http://feedbackme.herokuapp.com) for pricing, but is very cheap.
                       DESC
  s.homepage         = "https://github.com/leonardoobaptistaa/FeedbackMe"
  s.screenshots     = "http://feedbackme.herokuapp.com/screenshots-ios/ss01.png", "http://feedbackme.herokuapp.com/screenshots-ios/ss02.png", "http://feedbackme.herokuapp.com/screenshots-ios/ss03.png", "http://feedbackme.herokuapp.com/screenshots-ios/ss-feedback-screen.png"
  s.license          = 'MIT'
  s.author           = { "Leonardo Baptista" => "leonardoobaptistaa@gmail.com" }
  s.source           = { :git => "https://github.com/leonardoobaptistaa/FeedbackMe.git", :tag => '1.0.1' }
  s.social_media_url = 'https://twitter.com/leonardocbs'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'FeedbackMe' => ['Pod/Assets/*.png', 'Pod/Assets/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
