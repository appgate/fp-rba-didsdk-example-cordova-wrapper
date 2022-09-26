#import <Foundation/Foundation.h>
#import <didm_sdk/didm_sdk.h>
#import <objc/runtime.h>

@interface DIDPlugHelper : NSObject

+ (NSDictionary *)convertTransactionInfoToDictionary:(TransactionInfo*) transactionInfo;
+ (PushTransactionViewProperties*)convertJsonToPushTransactionViewProperties:(NSDictionary*)json;
+ (TransactionInfo*)convertJsonToPushTransactionInfo:(NSDictionary*)json;
+ (NSDictionary *)convertTransactionInfoToJson:(TransactionInfo *)transaction;
+ (Account*)convertJsonToAccount:(NSDictionary*)json;
+ (NSDictionary *)convertAccountToJson:(Account *)account;
+ (Gestures*)convertJsonToGestures:(NSDictionary*)json;
+ (Channel*)convertJsonToChannel:(NSDictionary*)json;
+ (NSDictionary *)convertObjectToDictionary:(id)obj;
+ (NSString *)convertObjectToString:(id)obj;
@end
