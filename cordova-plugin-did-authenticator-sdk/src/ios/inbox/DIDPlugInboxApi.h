#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>
#import "DetectIDCordovaPlugin.h"

@interface DIDPlugInboxApi: CDVPlugin

- (void)setupTransactionInbox:(CDVInvokedUrlCommand*)command;
- (void)getAllTransactionsByType:(CDVInvokedUrlCommand*)command;

@end
