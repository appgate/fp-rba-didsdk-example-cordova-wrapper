#import "DIDPlugHelper.h"
#import "DIDPlugConstantsHelper.h"
#import "TransactionsCache.h"

@implementation DIDPlugHelper

+ (PushTransactionViewProperties*)convertJsonToPushTransactionViewProperties:(NSDictionary*)json{
    
    PushTransactionViewProperties* pushTransactionVP = [[PushTransactionViewProperties alloc]init];
    pushTransactionVP.CONFIRM = [json valueForKeyPath: CONFIRM_PROPERTIES] ? : nil;
    pushTransactionVP.DECLINE = [json valueForKeyPath: DECLINE_PROPERTIES] ? : nil;
    NSString *quickActionParameter = ([json valueForKeyPath: ENABLE_NOTIFICATION_QUICK_ACTIONS_PROPERTIES] ? : nil);
    BOOL quickAction = NO;
    
    if (nil != quickActionParameter){
        quickAction = ([quickActionParameter boolValue] ? YES : NO);
    }
    
    pushTransactionVP.ENABLE_NOTIFICATION_QUICK_ACTIONS = quickAction;
    pushTransactionVP.SERVER_RESPONSE_CODE_96 = [json valueForKeyPath: SERVER_RESPONSE_CODE_96_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_98 = [json valueForKeyPath: SERVER_RESPONSE_CODE_98_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_99 = [json valueForKeyPath: SERVER_RESPONSE_CODE_99_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1001 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1001_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1002 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1002_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1012 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1012_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1020 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1020_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1021 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1021_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1022 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1022_PROPERTIES] ? : nil;
    
    return pushTransactionVP;
}

+ (TransactionInfo*)convertJsonToPushTransactionInfo:(NSDictionary*)json {
    TransactionInfo *transaction = [[TransactionsCache sharedInstance] getTransactionInfo:json];
    return transaction;
}

+ (NSDictionary *)convertTransactionInfoToJson:(TransactionInfo *)transaction {
    return @{
        TRANSACTION_ID: [self fixString: transaction.transactionID],
        SUBJECT: [self fixString: transaction.subject],
        MESSAGE_PROPERTIES: [self fixString: transaction.message],
        URL_TO_RESPONSE: [self fixString: transaction.urlToResponse],
        URL_TO_CONFIG_FACEID: [self fixString: transaction.urlToConfigFaceID],
        TIME_STAMP: [self fixString: [NSString stringWithFormat:@"%ld", transaction.timeStamp]],
        TRANSACTION_OFFLINE_CODE: [self fixString: transaction.transactionOfflineCode],
        ACCOUNT_PROPERTIES: [self convertAccountToJson:transaction.account],
        TYPE: [self fixString: [NSString stringWithFormat:@"%ld", transaction.type]],
        BIOMETRIC_TYPE: [self fixString: [NSString stringWithFormat:@"%ld", transaction.biometricType]],
        STATUS: [self fixString: [NSString stringWithFormat:@"%ld", transaction.status]]
    };
}

+ (NSString *)fixString:(NSString *)value {
    return value == nil ? @"" : value;
}

+ (Account*)convertJsonToAccount:(NSDictionary*)json{
    for (Account *account in [[DetectID sdk] getAccounts]) {
        if ([account.organizationName isEqual: [json valueForKeyPath: ORGANIZATION_NAME]] && [account.registrationDate isEqual: [json valueForKeyPath: REGISTRATION_DATE]])
        return account;
    }
    return nil;
}

+ (NSDictionary *)convertAccountToJson:(Account *)account {
    return @{
             USERNAME: account.username,
             ORGANIZATION_NAME : account.organizationName ,
             REGISTRATION_DATE : account.registrationDate ,
             ACTIVATION_URL : account.activationURL,
             ACTIVE_PUSH_AUTH : [NSNumber numberWithBool: account.activePushAuth],
             ACTIVE_QR_AUTH : [NSNumber numberWithBool:account.activeQRAuth],
             ACTIVE_PUSH_ALERT : [NSNumber numberWithBool:account.activePushAlert],
             ACTIVE_OTP_AUTH : [NSNumber numberWithBool:account.activeOTPAuth],
             ACTIVE_FACE_AUTH : [NSNumber numberWithBool:account.activeFaceAuth],
             REGISTRATION_METHOD : [NSNumber numberWithInt:account.registrationMethod]
             };
}

+ (NSDictionary *)convertTransactionInfoToDictionary:(TransactionInfo*) transactionInfo{
    
    NSDictionary *dictTransactionInfo = [self convertObjectToDictionary: transactionInfo];
    NSDictionary *dictAccount = [self convertObjectToDictionary: transactionInfo.account];
    NSDictionary *dictChannel = [self convertObjectToDictionary: transactionInfo.channel];
    NSDictionary *dictGestures = [self convertObjectToDictionary: transactionInfo.gestures];
    
    NSMutableDictionary *mutableDictionary = [dictTransactionInfo mutableCopy];
    
    [mutableDictionary setObject:dictAccount forKey:ACCOUNT_PROPERTIES];
    [mutableDictionary setObject:dictChannel forKey:CHANNEL_PROPERTIES];
    [mutableDictionary setObject:dictGestures forKey:GESTURES_PROPERTIES];
    
    dictTransactionInfo = [mutableDictionary mutableCopy];
    
    return dictTransactionInfo;
}

+ (NSDictionary *)convertObjectToDictionary:(id)obj
{
    if([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        if(![key isEqualToString: SUPERCLASS_PROPERTIES])
        {
            [dict setObject: [obj valueForKey:key] ? : @"" forKey:key];
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:[self sanitizeForJSON:dict]];
}

+ (id)sanitizeForJSON:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *sanitized = [NSMutableDictionary dictionary];
        for (id key in object) {
            sanitized[key] = [self sanitizeForJSON:object[key]];
        }
        return sanitized;
    } else if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *sanitized = [NSMutableArray array];
        for (id item in object) {
            [sanitized addObject:[self sanitizeForJSON:item]];
        }
        return sanitized;
    } else if ([object isKindOfClass:[NSDate class]]) {
        return @([(NSDate*)object timeIntervalSince1970] * 1000);
    }
    return object;
}

+ (NSString *)convertObjectToString:(id)obj {
    if([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    return @"";
}

@end
