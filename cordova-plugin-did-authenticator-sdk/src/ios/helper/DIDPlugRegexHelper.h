#import <Foundation/Foundation.h>

@interface DIDPlugRegexHelper : NSObject
+ (BOOL)validateStringFormat:(NSString *)string withPattern:(NSString *)pattern;
@end
