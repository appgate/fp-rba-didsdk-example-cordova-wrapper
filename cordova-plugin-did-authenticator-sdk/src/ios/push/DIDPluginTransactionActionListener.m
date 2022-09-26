#import "DIDPluginTransactionActionListener.h"
#import "DIDPlugHelper.h"

@implementation DIDPluginTransactionActionListener
{
	__block CDVInvokedUrlCommand *commandPluginTransactionActionListener;
    CDVPlugin *pushPlugin;
}

- (instancetype)initWithCommand : (CDVInvokedUrlCommand *) command withPlugin:(CDVPlugin*) plugin
{
    self = [super init];
    if (self) {
        commandPluginTransactionActionListener = command;
        pushPlugin = plugin;
        
        [[[DetectID sdk] getPushApi] setPushTransactionActionDelegate: self];
    }
    return self;
}

- (void)onConfirmPushTransaction:(TransactionInfo *)transaction {
    [self sendPluginResutWithTransactionInfo : transaction];
}

- (void)onDeclinePushTransaction:(TransactionInfo *)transaction {
    
    [self sendPluginResutWithTransactionInfo : transaction];
}

- (void)sendPluginResutWithTransactionInfo:(TransactionInfo *)transaction {
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: [DIDPlugHelper convertTransactionInfoToDictionary:transaction] ];
    [pluginResult setKeepCallbackAsBool:YES];
    [pushPlugin.commandDelegate sendPluginResult:pluginResult callbackId:commandPluginTransactionActionListener.callbackId];
}

@end 
