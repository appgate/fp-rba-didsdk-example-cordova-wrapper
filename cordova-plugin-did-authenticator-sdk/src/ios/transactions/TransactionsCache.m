#import "TransactionsCache.h"

static TransactionsCache *_sharedInstance = nil;

@implementation TransactionsCache {
    NSMutableDictionary *_transactionsDict;
}

+ (TransactionsCache *)sharedInstance {
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[TransactionsCache alloc] init];
        }
    }
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _transactionsDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setTransactions:(NSArray<TransactionInfo *> *)transactions {
    for (TransactionInfo *transaction in transactions) {
        if (transaction.transactionID && [self isPending:transaction]) {
            [_transactionsDict setObject:transaction forKey:transaction.transactionID];
        }
    }
}

- (BOOL)isPending:(TransactionInfo *)t {
    if(t.status == TransactionStatusALL) return true;
    if(t.type == TransactionTypePUSH_AUTHENTICATION) {
        return t.status == 1011;
    } else if(t.type == TransactionTypePUSH_ALERT) {
        return t.status != 2014;
    }
    return false;
}

- (TransactionInfo *)getTransactionInfo:(NSDictionary *)json {
    if (!json) {
        return nil;
    }
    NSString *transactionID = [json objectForKey:@"transactionID"];
    if (!transactionID || ![transactionID isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [_transactionsDict objectForKey:transactionID];
}

@end
