#import "DIDPlugAccountsApi.h"
#import "DIDPlugServerHelper.h"
#import "DIDPlugHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugRegistrationApi.h"
#import "DIDPlugConstantsHelper.h"

@implementation DIDPlugAccountsApi
{
    __block DIDPlugAccountsApi* pluginManager;
}

- (instancetype)init {
    return [super init];
}

- (void)getAccounts: (CDVInvokedUrlCommand*)command {
    __block DIDPlugAccountsApi* pluginBlock = self;
    
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        
        NSArray *accounts = [[DetectID sdk] getAccounts];

        NSMutableArray *jsonArray = [NSMutableArray new];
        
        for (Account *account in accounts) {
             [jsonArray addObject: [DIDPlugHelper convertAccountToJson:account]];
        }

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsArray: jsonArray.copy];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
    }
    @catch (NSException *e)
    {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)removeAccount:(CDVInvokedUrlCommand*) command{
    __block DIDPlugAccountsApi* pluginBlock = self;
    @try{
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;

        Account *account = [DIDPlugHelper convertJsonToAccount: [[commandBlock.arguments objectAtIndex:0] valueForKeyPath: @"currentAccount"]];

        [[DetectID sdk] removeAccount: account];

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];

    }@catch(NSException *ex) {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:ex]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)setAccountUsername:(CDVInvokedUrlCommand*) command{
    __block DIDPlugAccountsApi* pluginBlock = self;

    @try{
         __block CDVPluginResult* pluginResult;
         __block CDVInvokedUrlCommand* commandBlock = command;

        NSString *username = [[commandBlock.arguments objectAtIndex:0] valueForKeyPath:@"username"];
        Account *account = [DIDPlugHelper convertJsonToAccount: [[commandBlock.arguments objectAtIndex:0] valueForKeyPath: @"currentAccount"]];


        [[DetectID sdk] setAccountUsername: username forAccount: account];

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];

    }@catch(NSException *ex) {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:ex]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

@end
