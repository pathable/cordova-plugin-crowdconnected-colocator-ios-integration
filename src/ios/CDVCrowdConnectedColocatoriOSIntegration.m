#import "CDVCrowdConnectedColocatoriOSIntegration.h"
#import "AppDelegate+CDVCrowdConnectedColocatoriOSIntegration.h"

#import <objc/runtime.h>
#import <Cordova/CDVPlugin.h>
#import <CCLocation/CCLocation-Swift.h>

static NSString *const TAG = @"CDVCrowdConnectedColocatoriOSIntegration CDVPlugin";

@implementation CDVCrowdConnectedColocatoriOSIntegration

- (void) pluginInitialize
{
    NSLog(@"[%@] pluginInitialize", TAG);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

- (void) didFinishLaunchingNotification:(NSNotification*)notification
{
    NSLog(@"[%@] didFinishLaunchingNotification", TAG);

    @try {
        NSString* appKey = [self.commandDelegate.settings objectForKey:[@"crowdconnectedcolocatorappkey" lowercaseString]];

        [CCLocation.sharedInstance startWithApiKey:appKey urlString:@"URL_STRING"];

        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } @catch (NSException * e) {
        NSLog(@"[%@] Error: %@", TAG, [e reason]);
    }
}

- (void) start:(CDVInvokedUrlCommand*)command
{
    NSLog(@"[%@] start", TAG);

    CDVPluginResult* pluginResult = nil;

    @try {
        NSString* appKey = [command.arguments objectAtIndex:0];

        if (appKey != nil && [appKey length] > 0) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:appKey];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"appKey cannot be null"];
        }
    } @catch (NSException * e) {
        NSLog(@"[%@] Error: %@", TAG, [e reason]);

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[e reason]];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
