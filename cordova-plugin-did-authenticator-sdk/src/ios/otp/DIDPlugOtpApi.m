#import "DIDPlugOtpApi.h"
#import "DIDPlugHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugRegistrationApi.h"
#import "DIDPlugConstantsHelper.h"

@implementation DIDPlugOtpApi
{
    __block DIDPlugOtpApi* pluginManager;
}

- (instancetype)init {
    return [super init];
}

- (void)updateGlobalConfig:(CDVInvokedUrlCommand *)command {
    __block DIDPlugOtpApi* pluginBlock = self;
    
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        
        Account *account = [DIDPlugHelper convertJsonToAccount: [commandBlock.arguments objectAtIndex: 0]];
        
        [[DetectID sdk] updateGlobalConfig: account];

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
    }
    @catch (NSException *e)
    {
        [self handleException:e withBlock:pluginBlock andCommand:command];
    }
}

- (void)getTokenValue: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        __block DIDPlugOtpApi* pluginBlock = self;
        
        @try {
            __block CDVPluginResult* pluginResult;
            __block CDVInvokedUrlCommand* commandBlock = command;
            
            Account *account = [DIDPlugHelper convertJsonToAccount: [commandBlock.arguments objectAtIndex:0]];
            
            NSString *token = [[[DetectID sdk] getOtpApi] getTokenValue: account];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: token];
            [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
        }
        @catch (NSException *e)
        {
            [self handleException:e withBlock:pluginBlock andCommand:command];
        }
    }];
}

- (void)getChallengeTokenValue:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        __block DIDPlugOtpApi* pluginBlock = self;
        
        @try {
            __block CDVPluginResult* pluginResult;
            __block CDVInvokedUrlCommand* commandBlock = command;
            
            NSDictionary *dict = [DIDPlugHelper convertObjectToDictionary: [commandBlock.arguments objectAtIndex:0]];
            Account *account = [DIDPlugHelper convertJsonToAccount: [dict objectForKey: ACCOUNT_PROPERTIES]];
            NSString *challenge = [DIDPlugHelper convertObjectToString: [dict objectForKey: ANSWER_PROPERTIES]];
            
            NSString *token = [[[DetectID sdk] getOtpApi] getChallengeQuestionOtpWithAccount:account answer:challenge];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: token];
            [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
        }
        @catch (NSException *e)
        {
            [self handleException:e withBlock:pluginBlock andCommand:command];
        }
    }];
}

- (void)handleException:(NSException*)e withBlock:(DIDPlugOtpApi*)pluginBlock andCommand:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
    [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
}

@end
