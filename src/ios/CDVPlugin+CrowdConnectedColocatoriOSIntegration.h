#import <Cordova/CDVPlugin.h>

@interface CrowdConnectedColocatoriOSIntegration : CDVPlugin

+ (NSString *) appKey;

+ (BOOL) isAppKeyValid;

@end
