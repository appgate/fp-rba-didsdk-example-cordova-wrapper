#import "DIDPluginTransactionServerResponseListener.h"

@implementation DIDPluginTransactionServerResponseListener
{
    __block CDVInvokedUrlCommand *commandPluginTransactionServerResponseListener;
    CDVPlugin *pushPlugin;
}

- (instancetype)initWithCommand : (CDVInvokedUrlCommand *) command withPlugin:(CDVPlugin*) plugin
{
    self = [super init];
    if (self) {
        self.myPushListenerCallbackId = command.callbackId;
        commandPluginTransactionServerResponseListener = command;
        pushPlugin = plugin;
        
        [[[DetectID sdk] getPushApi] setPushTransactionServerResponseDelegate: self];
    }
    return self;
}

- (void)onPushTransactionServerResponse:(NSString *)result {
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: result];
    //[pluginResult setKeepCallbackAsBool:YES];
    //[pushPlugin.commandDelegate sendPluginResult:pluginResult callbackId:commandPluginTransactionServerResponseListener.callbackId];
    [pushPlugin.commandDelegate sendPluginResult:pluginResult callbackId: _myPushListenerCallbackId];
}

@end
