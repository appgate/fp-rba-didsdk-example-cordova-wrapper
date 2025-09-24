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

- (void)approvePushAlertAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    TransactionInfo *transaction = [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]];
    [[[DetectID sdk] getPushApi] approvePushAlertAction:transaction];
}

-(PushAlertViewProperties*)convertJsonToPushAlertViewProperties:(NSDictionary*)json{
    PushAlertViewProperties* pushAlertVP = [[PushAlertViewProperties alloc]init];
    pushAlertVP.APPROVE = [json valueForKeyPath: APPROVE_PROPERTIES] ? : nil;
        
    return pushAlertVP;
}

@end
