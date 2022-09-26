#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>

@interface DIDPluginTransactionServerResponseListener : NSObject <PushTransactionServerResponseDelegate>
@property (nonatomic, strong) NSString *myPushListenerCallbackId;
- (instancetype)initWithCommand : (CDVInvokedUrlCommand *) command withPlugin:(CDVPlugin*) plugin;
@end
