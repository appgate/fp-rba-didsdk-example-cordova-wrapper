#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>

@interface DIDPluginPushAlertOpenListener : NSObject <PushAlertOpenDelegate>

@property(nonatomic,strong) TransactionInfo* transactionInfo;

+ (id)sharedInstance;
- (void)setCommand:(CDVInvokedUrlCommand *)command withPlugin: (CDVPlugin*)plugin;

@end
