#import "AppDelegate.h"
#import "CDVCrowdConnectedColocatoriOSIntegration.h"
#import "AppDelegate+CDVCrowdConnectedColocatoriOSIntegration.h"

#import <objc/runtime.h>
#import <CCLocation/CCLocation-Swift.h>

static NSString *const TAG = @"CDVCrowdConnectedColocatoriOSIntegration AppDelegate";

@implementation AppDelegate (CDVCrowdConnectedColocatoriOSIntegration)

+ (void) load
{
    NSLog(@"[%@] load", TAG);
}

- (void) application:(UIApplication*)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"[%@] performFetchWithCompletionHandler", TAG);

    @try {
        [CCLocation.sharedInstance updateLibraryBasedOnClientStatusWithClientKey:@"YOUR_APP_KEY" isSilentNotification:false completion:^(BOOL result) {}];
    } @catch (NSException * e) {
        NSLog(@"[%@] Error: %@", TAG, [e reason]);
    }
}

- (void) application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"[%@] didRegisterForRemoteNotificationsWithDeviceToken", TAG);

    @try {
        NSString * deviceTokenString = [[[[deviceToken description]
            stringByReplacingOccurrencesOfString: @"<" withString: @""]
            stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];

        [CCLocation.sharedInstance addAliasWithKey:@"apns_user_id" value:deviceTokenString];
    } @catch (NSException * e) {
        NSLog(@"[%@] Error: %@", TAG, [e reason]);
    }
}

- (void) application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"[%@] didFailToRegisterForRemoteNotificationsWithError: %@", TAG, [error localizedDescription]);
}

- (void) application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"[%@] didReceiveRemoteNotification", TAG);

    @try {
        NSDictionary *apsInfo = [userInfo objectForKey:@"apsInfo"];
        NSString *source = [apsInfo objectForKey:@"source"];

        if ([source isEqualToString:@"colcoator"]) {
            [CCLocation.sharedInstance receivedSilentNotificationWithUserInfo:userInfo clientKey:@"YOUR_APP_KEY" completion:^(BOOL result) {}];
        }
    } @catch (NSException * e) {
        NSLog(@"[%@] Error: %@", TAG, [e reason]);
    }
}

@end
