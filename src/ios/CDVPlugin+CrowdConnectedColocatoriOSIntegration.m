#import "CDVPlugin+CrowdConnectedColocatoriOSIntegration.h"
#import "AppDelegate+CrowdConnectedColocatoriOSIntegration.h"

#import <objc/runtime.h>
#import <Cordova/CDVPlugin.h>
#import <CCLocation/CCLocation-Swift.h>

static NSString *const TAG = @"CrowdConnectedColocatoriOSIntegration CDVPlugin";
static NSString *appKey;
static BOOL *isAppKeyValid;

@implementation CrowdConnectedColocatoriOSIntegration

+ (NSString *) appKey
{
    return appKey;
}

+ (BOOL) isAppKeyValid
{
    return isAppKeyValid;
}

- (void) updateAppKey
{
    appKey = [self.commandDelegate.settings objectForKey:[@"crowdconnectedcolocatorappkey" lowercaseString]];
    isAppKeyValid = (appKey != nil && [appKey length] > 0);
}

- (void) pluginInitialize
{
    [self updateAppKey];

    if (isAppKeyValid) {
        NSLog(@"[%@] appKey is valid", TAG);

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
}

- (void) didFinishLaunchingNotification:(NSNotification *)notification
{
    if (isAppKeyValid) {
        NSLog(@"[%@] didFinishLaunchingNotification", TAG);

        @try {
            [CCLocation.sharedInstance startWithApiKey:appKey urlString:@"URL_STRING"];

            [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        } @catch (NSException *e) {
            NSLog(@"[%@] Error: %@", TAG, [e reason]);
        }
    }
}

@end
