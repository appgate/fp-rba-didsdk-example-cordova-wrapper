#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>

@interface DIDPlugPushApi : CDVPlugin
    
- (void) setPushTransactionViewProperties:(CDVInvokedUrlCommand*)command;
- (void) setPushAlertViewProperties:(CDVInvokedUrlCommand*)command;
- (void) setPushTransactionServerResponseListener:(CDVInvokedUrlCommand*)command;
- (void) setPushTransactionOpenListener: (CDVInvokedUrlCommand*)command;
- (void) setPushTransactionActionListener: (CDVInvokedUrlCommand*)command;
- (void) setPushAlertOpenListener: (CDVInvokedUrlCommand*)command;
@end
