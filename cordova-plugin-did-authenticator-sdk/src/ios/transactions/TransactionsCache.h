#import <Foundation/Foundation.h>
#import <didm_sdk/didm_sdk.h>

@interface TransactionsCache : NSObject

+ (instancetype)sharedInstance;
- (void)setTransactions:(NSArray<TransactionInfo *> *)transactions;
- (TransactionInfo *)getTransactionInfo:(NSDictionary *)json;

@end
