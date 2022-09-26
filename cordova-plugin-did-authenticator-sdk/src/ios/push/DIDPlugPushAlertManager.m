#import "DIDPlugPushApi.h"
#import "DIDPlugConstantsHelper.h"
#import "DIDPlugPushAlertManager.h"
#import "DIDPlugHelper.h"

@implementation DIDPlugPushAlertManager
{
}

- (instancetype)init {
    return [super init];
}

-(void)setPushAlertViewProperties: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    __block CDVPluginResult* pluginResult;
    __block CDVInvokedUrlCommand* commandProperties = command;

    PushAlertViewProperties *pushAlertVP = [self convertJsonToPushAlertViewProperties: [commandProperties.arguments objectAtIndex:0]];
        
    [[[DetectID sdk] getPushApi] setPushAlertViewProperties: pushAlertVP];
    
    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
    [pluginPushApi.commandDelegate sendPluginResult: pluginResult callbackId:commandProperties.callbackId];
}

- (void)approvePushAlertAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] getPushApi] approvePushAlertAction:[DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]]];
}

-(PushAlertViewProperties*)convertJsonToPushAlertViewProperties:(NSDictionary*)json{
    PushAlertViewProperties* pushAlertVP = [[PushAlertViewProperties alloc]init];
    pushAlertVP.APPROVE = [json valueForKeyPath: APPROVE_PROPERTIES] ? : nil;
        
    return pushAlertVP;
}

@end
