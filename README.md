## Install

The library is compatible with Cocoapods. 
Just add this to your Podfile:

```
pod 'LinkToMyApp', :podspec => "https://raw.github.com/LinkToMyApp/linktomyapp-iOS/master/LinkToMyApp.podspec"
```

If you don't want to use Cocoapods just drag the LinkToMyApp.h and .m files to your project.

## Basic usage

First you need to initialize the SDK at the Application start.
In the AppDidFinishLaunching of your Application Delegate, start the linker with the server url and the iTunes ID of your app.

```objective-c
#import "LinkToMyApp.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
 	[LinkToMyApp startLinkerOnEndpoint:[NSURL URLWithString:@"http://linktomyapp.herokuapp.com/"] andAppID:@"1234"];
    
/...
your code
.../

	return YES;
}
```

## Log events

You can log all kind of event to track your user conversion and behaviors.

```objective-c
-(IBAction)createAccountAction:(id)sender
{
    [[LinkToMyApp linker] notifyServerForEvent:@"create_account" withInfos:@{@"username" : @"John"}];
}

-(IBAction)purchaseAction:(id)sender
{
    [[LinkToMyApp linker] notifyServerForEvent:@"purchase_inapp" withInfos:@{@"credits" : @500}];
}
```

Your Linker need to be instantiate with a valid server URL and App ID before.
Otherwyse the "linker" method will return nil.