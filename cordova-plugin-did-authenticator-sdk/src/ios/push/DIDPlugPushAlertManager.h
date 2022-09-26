#import <Foundation/Foundation.h>
#import <didm_sdk/didm_sdk.h>

@interface DIDPlugPushAlertManager : NSObject

- (void)setPushAlertViewProperties: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi;

- (void)approvePushAlertAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi;
@end