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

@end
