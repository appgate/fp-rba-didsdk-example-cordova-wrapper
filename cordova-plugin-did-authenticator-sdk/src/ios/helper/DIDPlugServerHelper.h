#import <Foundation/Foundation.h>

@interface DIDPlugServerHelper : NSObject
+ (DIDPlugServerHelper *)getInstance:(NSString *)serverURL;
- (NSString *)getServerURL;
@end
