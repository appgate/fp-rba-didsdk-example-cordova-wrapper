#import "DIDPlugQRAuthenticationApi.h"
#import "DIDPlugHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugConstantsHelper.h"

@implementation DIDPlugQRAuthenticationApi
{
    __block DIDPlugQRAuthenticationApi* pluginManager;
    __block CDVInvokedUrlCommand *commandBlock;
}

- (instancetype)init {
    return [super init];
}

- (void)setQRDelegates {
    [[[DetectID sdk] getQrApi] setQRCodeScanTransactionDelegate:self];
    [[[DetectID sdk] getQrApi] setQRCodeTransactionServerResponseDelegate:self];
}

// QRCodeScanTransactionDelegate
- (void)onQRCodeScanTransaction:(TransactionInfo*)transaction{
    __block DIDPlugQRAuthenticationApi *pluginBlock = self;
    NSDictionary *transactionDict = [DIDPlugHelper convertTransactionInfoToJson: transaction];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:transactionDict];
    [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
}

// QRCodeTransactionServerResponseDelegate
- (void)onQRCodeTransactionServerResponse:(NSString *)response {
    __block DIDPlugQRAuthenticationApi *pluginBlock = self;
    CDVPluginResult *pluginResult;
    if([response  isEqual: @"1020"]) {
        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: @"OK"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString: response];
    }
    [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
}

- (void)confirmQRCodeTransaction:(CDVInvokedUrlCommand*)command {
    [self setQRDelegates];
    self->commandBlock = command;
    [self onConfirmQRCodeTransaction: [self getTransaction]];
}
- (void)declineQRCodeTransaction:(CDVInvokedUrlCommand*)command {
    [self setQRDelegates];
    self->commandBlock = command;
    [self onDeclineQRCodeTransaction: [self getTransaction]];
}

// QRCodeTransactionActionDelegate
- (void)onConfirmQRCodeTransaction:(TransactionInfo *)transaction {
    [[[DetectID sdk] getQrApi] confirmQRCodeTransactionAction:transaction];
}
- (void)onDeclineQRCodeTransaction:(TransactionInfo *)transaction {
    [[[DetectID sdk] getQrApi] declineQRCodeTransactionAction:transaction];
}

- (TransactionInfo *)getTransaction {
    return [DIDPlugHelper convertJsonToPushTransactionInfo: [commandBlock.arguments objectAtIndex:0]];
}

- (void)qrAuthenticationProcess:(CDVInvokedUrlCommand*)command {
    __block DIDPlugQRAuthenticationApi *pluginBlock = self;
    [self setQRDelegates];
    @try {
        __block CDVPluginResult *pluginResult;
        self->commandBlock = command;

        NSDictionary *dict = [commandBlock.arguments objectAtIndex:0];
        NSString *qrContent = [dict valueForKeyPath: DATA_KEY];
        Account *account = [DIDPlugHelper convertJsonToAccount: [dict valueForKeyPath: ACCOUNT_PROPERTIES]];
        [[[DetectID sdk] getQrApi] qrAuthenticationProcess:account withQrContent: qrContent];

    } @catch (NSException *e){
        [self handleException:e withBlock:pluginBlock andCommand:command];
    }
}

- (void)handleException:(NSException*)e withBlock:(DIDPlugQRAuthenticationApi*)pluginBlock andCommand:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
    [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
}

@end
