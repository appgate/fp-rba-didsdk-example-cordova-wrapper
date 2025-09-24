#import "DIDPlugPushApi.h"
#import "DIDPlugConstantsHelper.h"
#import "DIDPlugPushTransactionManager.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugHelper.h"

@implementation DIDPlugPushTransactionManager{
}

- (instancetype)init {
    return [super init];
}

- (void)confirmPushTransactionAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi {
    __block DIDPlugPushApi* pluginBlock = pluginPushApi;

    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        
        TransactionInfo *transaction = [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]];
        [[[DetectID sdk] getPushApi] confirmPushTransactionAction:transaction onSuccess:^{
            pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
            [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
        } onFailure:^(AGSDKError * _Nonnull error) {
            CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:FALSE];
            [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
        }];
    }
    @catch (NSException *e)
    {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)declinePushTransactionAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi {
    __block DIDPlugPushApi* pluginBlock = pluginPushApi;
    
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        
        TransactionInfo *transaction = [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]];
        [[[DetectID sdk] getPushApi] declinePushTransactionAction:transaction onSuccess:^{
            pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
            [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
        } onFailure:^(AGSDKError * _Nonnull error) {
            CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:FALSE];
            [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
        }];
    }
    @catch (NSException *e)
    {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)setPushAuthenticationResponseAdditionalInfo: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi {
    [[[DetectID sdk] getPushApi] setPushAuthenticationResponseAdditionalInfo:[command.arguments objectAtIndex:0]];
}

@end
