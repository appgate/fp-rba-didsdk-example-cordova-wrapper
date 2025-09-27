#import "DIDPlugInboxApi.h"
#import "DIDPlugHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "TransactionsCache.h"

@implementation DIDPlugInboxApi
{
    __block DIDPlugInboxApi* pluginManager;
}

- (instancetype)init {
    return [super init];
}

- (void)setupTransactionInbox:(CDVInvokedUrlCommand*)command {
    __block DIDPlugInboxApi* pluginBlock = self;
    
    @try {
        __block CDVInvokedUrlCommand *commandBlock = command;
        
        NSString *urlPushAlert = [commandBlock.arguments objectAtIndex:0];
        NSString *urlPushAuth = [commandBlock.arguments objectAtIndex:1];
        NSString *urlPushBiometric = [commandBlock.arguments objectAtIndex:2];
        
        [[[DetectID sdk] getInboxApi] setupTransactionInbox: urlPushAlert urlPushAuth:urlPushAuth urlPushBiometric:urlPushBiometric];
    }
    @catch (NSException *e)
    {
        [self handleException:e withBlock:pluginBlock andCommand:command];
    }
}

- (void)getAllTransactionsByType:(CDVInvokedUrlCommand*)command {
    __block DIDPlugInboxApi* pluginBlock = self;
    
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        
        Account *account = [DIDPlugHelper convertJsonToAccount: [commandBlock.arguments objectAtIndex: 0]];
        NSNumber *typeN = [commandBlock.arguments objectAtIndex:1];
        NSNumber *statusN = [commandBlock.arguments objectAtIndex:2];
        NSNumber *page = [commandBlock.arguments objectAtIndex:3];
        
        TransactionType type = (TransactionType)typeN.integerValue;
        TransactionStatus status = (TransactionStatus)statusN.integerValue;
        
        [[[DetectID sdk] getInboxApi]
         getAllTransactionsByType: account type:type withStatus:status page:page.intValue
         onResponseSuccessfull:^(NSArray *arrayTransactionInfo, int totalPages, int totalRecords) {
            NSMutableArray *jsonArray = [NSMutableArray array];
            for (int i = 0; i<arrayTransactionInfo.count; i++) {
                NSDictionary *transactionDict = [DIDPlugHelper convertTransactionInfoToJson: arrayTransactionInfo[i]];
                [jsonArray addObject:transactionDict];
            }
            [[TransactionsCache sharedInstance] setTransactions:arrayTransactionInfo];
            
            NSMutableDictionary *responseDict = [NSMutableDictionary dictionary];
            [responseDict setValue:jsonArray.copy forKey:@"arrayTransactionInfo"];
            [responseDict setValue:[NSNumber numberWithInt:totalPages] forKey:@"totalPages"];
            [responseDict setValue:[NSNumber numberWithInt:totalRecords] forKey:@"totalRecords"];
            
            pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsDictionary: responseDict.copy];
            [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
        }
         onResponseFail:^(NSString *result) {
            CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:result];
            [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
        }];
    }
    @catch (NSException *e)
    {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)handleException:(NSException*)e withBlock:(DIDPlugInboxApi*)pluginBlock andCommand:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
    [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
}

@end
