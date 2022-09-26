#import "DIDPlugPushApi.h"
#import "DIDPlugConstantsHelper.h"
#import "DIDPlugPushTransactionManager.h"
#import "DIDPlugPushAlertManager.h"
#import "DIDPluginTransactionServerResponseListener.h"
#import "DIDPluginTransactionOpenListener.h"
#import "DIDPluginTransactionActionListener.h"
#import "DIDPluginPushAlertOpenListener.h"
#import <didm_sdk/didm_sdk.h>

@implementation DIDPlugPushApi
{
    __block DIDPlugPushTransactionManager *pushTransactionManager;
    __block DIDPlugPushAlertManager *pushAlertManager;
}

- (instancetype)init {
    return [super init];
}

-(void)setPushTransactionViewProperties: (CDVInvokedUrlCommand*)command{

    pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];    
    [pushTransactionManager setPushTransactionViewProperties:command withPlugin:self];
}

-(void)confirmPushTransactionAction: (CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    
    [self.commandDelegate runInBackground:^{
        [[DIDPluginTransactionServerResponseListener alloc] initWithCommand:commandBlock withPlugin:self]; //setPushTransactionServerResponseListener
        self->pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];
        [self->pushTransactionManager confirmPushTransactionAction:commandBlock withPlugin:self];
    }];
}

-(void)declinePushTransactionAction: (CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
        [[DIDPluginTransactionServerResponseListener alloc] initWithCommand:commandBlock withPlugin:self]; //setPushTransactionServerResponseListener
        self->pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];
        [self->pushTransactionManager declinePushTransactionAction:commandBlock withPlugin:self];
    }];
}

-(void)setPushAuthenticationResponseAdditionalInfo: (CDVInvokedUrlCommand*)command{
    
    pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];          
    [pushTransactionManager setPushAuthenticationResponseAdditionalInfo:command withPlugin:self];
}

-(void)approvePushAlertAction: (CDVInvokedUrlCommand*)command{

    pushAlertManager = [[DIDPlugPushAlertManager alloc]init];       
    [pushAlertManager approvePushAlertAction:command withPlugin:self];
}

-(void)setPushAlertViewProperties: (CDVInvokedUrlCommand*)command{

    pushAlertManager = [[DIDPlugPushAlertManager alloc]init];    
    [pushAlertManager setPushAlertViewProperties:command withPlugin:self];
}

-(void)setPushTransactionServerResponseListener: (CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
    [[DIDPluginTransactionServerResponseListener alloc] initWithCommand:commandBlock withPlugin:self];
        }];
}

-(void)setPushTransactionOpenListener: (CDVInvokedUrlCommand*)command{
    
    [[DIDPluginTransactionOpenListener sharedInstance] setCommand:command withPlugin:self];
}

-(void)setPushTransactionActionListener: (CDVInvokedUrlCommand*)command{
    
    [[DIDPluginTransactionActionListener alloc] initWithCommand:command withPlugin:self];
}

-(void)setPushAlertOpenListener: (CDVInvokedUrlCommand*)command{
    
    [[DIDPluginPushAlertOpenListener sharedInstance] setCommand:command withPlugin:self];
}

@end
