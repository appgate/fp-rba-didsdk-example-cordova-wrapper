#import <Foundation/Foundation.h>
#import <didm_sdk/didm_sdk.h>

@interface DIDPlugPushAlertManager : NSObject

- (void)approvePushAlertAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi;

@end