#import "DIDPlugPushApi.h"
#import "DIDPlugConstantsHelper.h"
#import "DIDPlugPushTransactionManager.h"
#import "DIDPlugHelper.h"

@implementation DIDPlugPushTransactionManager{
}

- (instancetype)init {
    return [super init];
}

-(void)setPushTransactionViewProperties: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    __block CDVInvokedUrlCommand* commandProperties = command;
    
    NSError *jsonError;
    NSData *objectData = [[commandProperties.arguments objectAtIndex:0] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&jsonError];
    
    [[[DetectID sdk] getPushApi] setPushTransactionViewProperties:[DIDPlugHelper convertJsonToPushTransactionViewProperties:json]];
}

- (void)confirmPushTransactionAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] getPushApi] confirmPushTransactionAction : [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]]];
}

- (void)declinePushTransactionAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] getPushApi] declinePushTransactionAction: [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]]];
}

- (void)setPushAuthenticationResponseAdditionalInfo: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] getPushApi] setPushAuthenticationResponseAdditionalInfo:[command.arguments objectAtIndex:0]];
}

@end
