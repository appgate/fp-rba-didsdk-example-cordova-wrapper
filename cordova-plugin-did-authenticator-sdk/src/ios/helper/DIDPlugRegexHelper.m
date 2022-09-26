#import "DIDPlugRegexHelper.h"
#import "DIDPlugConstantsHelper.h"

@implementation DIDPlugRegexHelper
/**
 This method compares a string with a regular expression and validates if the string has a valid format
 
 @param string is the string that will be compare with the regular expression
 @param pattern is the regular expression to evaluate
 @return BOOL value about the format of the string, is valid YES and invalid NO
 */
+ (BOOL)validateStringFormat:(NSString *)string withPattern:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, ERROR_CREATING_REGEX);
    
    NSRange textRange = NSMakeRange(0,string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    BOOL didValidate = NO;
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
    didValidate = YES;
    
    return didValidate;
}
@end
