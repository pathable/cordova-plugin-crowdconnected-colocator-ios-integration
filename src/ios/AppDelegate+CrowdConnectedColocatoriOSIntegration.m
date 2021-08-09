#import "AppDelegate.h"
#import "CDVPlugin+CrowdConnectedColocatoriOSIntegration.h"
#import "AppDelegate+CrowdConnectedColocatoriOSIntegration.h"

#import <objc/runtime.h>
#import <CCLocation/CCLocation-Swift.h>

static NSString *const TAG = @"CrowdConnectedColocatoriOSIntegration AppDelegate";

@implementation AppDelegate (CrowdConnectedColocatoriOSIntegration)

- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if ([CrowdConnectedColocatoriOSIntegration isAppKeyValid]) {
        NSLog(@"[%@] performFetchWithCompletionHandler", TAG);

        @try {
            [CCLocation.sharedInstance updateLibraryBasedOnClientStatusWithClientKey:[CrowdConnectedColocatoriOSIntegration appKey] isSilentNotification:false completion:^(BOOL result) {}];
        } @catch (NSException *e) {
            NSLog(@"[%@] Error: %@", TAG, [e reason]);
        }
    }
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    if ([CrowdConnectedColocatoriOSIntegration isAppKeyValid]) {
        NSLog(@"[%@] didRegisterForRemoteNotificationsWithDeviceToken", TAG);

        @try {
            NSString * deviceTokenString = [[[[deviceToken description]
                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                stringByReplacingOccurrencesOfString: @">" withString: @""]
                stringByReplacingOccurrencesOfString: @" " withString: @""];

            [CCLocation.sharedInstance addAliasWithKey:@"apns_user_id" value:deviceTokenString];
        } @catch (NSException *e) {
            NSLog(@"[%@] Error: %@", TAG, [e reason]);
        }
    }
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if ([CrowdConnectedColocatoriOSIntegration isAppKeyValid]) {
        NSLog(@"[%@] didFailToRegisterForRemoteNotificationsWithError: %@", TAG, [error localizedDescription]);
    }
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ([CrowdConnectedColocatoriOSIntegration isAppKeyValid]) {
        NSLog(@"[%@] didReceiveRemoteNotification", TAG);

        @try {
            NSDictionary *apsInfo = [userInfo objectForKey:@"apsInfo"];
            NSString *source = [apsInfo objectForKey:@"source"];

            if ([source isEqualToString:@"colcoator"]) {
                [CCLocation.sharedInstance receivedSilentNotificationWithUserInfo:userInfo clientKey:[CrowdConnectedColocatoriOSIntegration appKey] completion:^(BOOL result) {}];
            }
        } @catch (NSException *e) {
            NSLog(@"[%@] Error: %@", TAG, [e reason]);
        }
    }
}

@end
