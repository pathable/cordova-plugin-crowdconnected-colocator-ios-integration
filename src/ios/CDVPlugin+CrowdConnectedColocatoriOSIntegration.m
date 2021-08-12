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

- (void) updateAppKey:(NSString *)key
{
    appKey = key;
    isAppKeyValid = (key != nil && [key length] > 0);
}

- (void) start:(CDVInvokedUrlCommand *)command
{
    NSLog(@"[%@] start", TAG);

    CDVPluginResult* pluginResult = nil;

    @try {
        [self updateAppKey:[command.arguments objectAtIndex:0]];

        if (isAppKeyValid) {
            NSLog(@"[%@] appKey is valid", TAG);

            NSString *urlString = [NSString stringWithFormat:@"%@.colocator.net", appKey];
            [CCLocation.sharedInstance startWithApiKey:appKey urlString:urlString];

            [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60];
            [[UIApplication sharedApplication] registerForRemoteNotifications];

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            NSLog(@"[%@] appKey is invalid", TAG);

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"appKey is invalid"];
        }
    } @catch (NSException *e) {
        NSLog(@"[%@] Error: %@", TAG, [e reason]);

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[e reason]];
    } @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
