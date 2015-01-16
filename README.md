# FeedbackMe

[![CI Status](https://travis-ci.org/leonardoobaptistaa/FeedbackMe.svg?branch=1.0.0&style=flat)](https://travis-ci.org/Leonardo Baptista/FeedbackMe)
[![Version](https://img.shields.io/cocoapods/v/FeedbackMe.svg?style=flat)](http://cocoadocs.org/docsets/FeedbackMe)
[![License](https://img.shields.io/cocoapods/l/FeedbackMe.svg?style=flat)](http://cocoadocs.org/docsets/FeedbackMe)
[![Platform](https://img.shields.io/cocoapods/p/FeedbackMe.svg?style=flat)](http://cocoadocs.org/docsets/FeedbackMe)

FeedbackMe is a Pod to simply the request for feedback/reviews to your users. It is similar to the [Appirater](https://github.com/arashpayan/appirater), but the main difference is that we will not ask for feedback when the user is opening your app.

## Screenshots

![Screenshots 01](http://feedbackme.herokuapp.com/screenshots-ios/ss01.png?1)
![Screenshots 02](http://feedbackme.herokuapp.com/screenshots-ios/ss02.png?1)
![Screenshots 03](http://feedbackme.herokuapp.com/screenshots-ios/ss03.png?1)
![Screenshots Feedback Screen](http://feedbackme.herokuapp.com/screenshots-ios/ss-feedback-screen.png?1)

## Pre-Requisites

You can use this Pod in two ways:

### Using your own view controllers to receive custom feedback.

This way you can customize what feedback do you want, and upload it to your
server or do whatever you want to.

It's free too.

or

### Register your app on [FeedbackMe](http://feedbackme.herokuapp.com/)

If you choose to use [FeedbackMe API](http://feedbackme.herokuapp.com/),
there is a view already done asking for name, email and user opinion.

#### Pricing

* You can use our backend for free until you reach 50 feedbacks
* Between 50 and 1,000 feedbacks, it cost $1 per month per app (that passes 50 feedbacks)
* More than 1,000 feedbacks, costs $5 per month per app (that passes 1,000 feedbacks)

## Installation

FeedbackMe is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
#Podfile
pod 'FeedbackMe', '~> 1.0'
```

Then go to your terminal and run:
```shell
pod install
```

## Initial Setup

First you will need your Itunes ID. You can find it on Itunes link to your app.
Example: [https://itunes.apple.com/br/app/me-lembra-clovis/id928556821](https://itunes.apple.com/br/app/me-lembra-clovis/id928556821)
this app id is "id928556821" (without quotes). If your app is not published yet,
you can use another one to test, but as soon as you register your app on
Itunes Connect, remember to change it. Apple gives your app an id upon Itunes
Connect app registration.

We use this info to be able to open your Itunes page.

Then you have to decide if you will implement your own feedback api, our use
ours.

### Using custom code

You have to call setup on your AppDelegate.m file, inside the application didFinishLaunchingWithOptions method:

```objc
//AppDelegate.m

#import <LBFeedbackMe.h>

- (void) setupFeedbackMe {
    [LBFeedbackMe setupWithAppStoreId:@"id928556821" openFeedbackViewBlock:^{
        UIViewController *actualViewController; //Get current view controller from AppDelegate or other place
        UIViewController *feedbackViewController = [UIViewController new]; //Instantiate your custom feedback view controller
        [actualViewController presentViewController:feedbackViewController animated:true completion:nil];
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupFeedbackMe];
    return YES;
}
```

### Using with [FeedbackMe](http://feedbackme.herokuapp.com/) api key

First of all, thank you for supporting us :)

You have to call setup on your AppDelegate.m file, inside the application didFinishLaunchingWithOptions method:

```objc
//AppDelegate.m

#import <LBFeedbackMe.h>

- (void) setupFeedbackMe {
  [LBFeedbackMe setupWithAppStoreId:@"id928556821" andApiKey:@"YOUR-API-KEY"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupFeedbackMe];
    return YES;
}
```

## Events
After setting up, you have to decide when your app will ask for feedback.

For example, let's say that you will ask for feedback after a user register and like three photos:

```objc
//AppDelegate.m
- (void) setupFeedbackMe {
  [LBFeedbackMe setupWithAppStoreId:@"id928556821" andApiKey:@"YOUR-API-KEY"];
  [LBFeedbackMe waitForEvent:@"REGISTER" times: @1];
  [LBFeedbackMe waitForEvent:@"LIKE_PHOTO" times: @3];
}
```

Ok, now your app is waiting for events to present the feedback view.
You just have to tell when these events happen. For example:

```objc
//CustomRegistrationViewController.m
- (void) userRegistered
{
    //Custom code
    [LBFeedbackMe eventFired:@"REGISTER"];
}

//CustomPhotosViewController.m
- (void) likePhoto
{
    //Custom code
    [LBFeedbackMe eventFired:@"LIKE_PHOTO"];
}
```

After userRegistered is called once and likePhoto is called three times, a
popup will be presented asking for user feedback.

## Localization

You can add these string to your Localization file, and FeedbackMe will load then:

```objc
//Localizable.strings
"First Feedback Alert Title" = "Quick Feedback";
"First Feedback Alert Message" = "Are you enjoying this app?";
"First Feedback Button Yes" = "Yes, very much!";
"First Feedback Button Confused" = "I am confused";
"First Feedback Button No" = "Not actually";

"Positive Feedback Alert Title" = "That's nice. Thank you";
"Positive Feedback Alert Message" = "Since you are liking our app, can you help us by leaving a review on the AppStore?";
"Positive Feedback Button Yes" = "Sure!";
"Positive Feedback Button No" = "No";

"Negative Feedback Alert Title" = "How can we improve?";
"Negative Feedback Alert Message" = "Do you want to tell us how to improve our app and make you happy? :)";
"Negative Feedback Button Yes" = "Sure!";
"Negative Feedback Button No" = "No";

"Name" = "Name";
"E-mail" = "E-mail";
"How can we improve?" = "How can we improve?";
```

## Contributions

If you want to add somethings, please do! And open a pull request later.

It will be nice to have a way to customize the feedback view controller layout.
I will implement this on a future version.

## Author

Leonardo Baptista, leonardoobaptistaa@gmail.com

## License

FeedbackMe is available under the MIT license. See the LICENSE file for more info.
