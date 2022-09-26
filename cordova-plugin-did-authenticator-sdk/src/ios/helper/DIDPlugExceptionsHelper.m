#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugConstantsHelper.h"

@implementation DIDPlugExceptionsHelper
- (NSException *)nullParameterException {
    return [NSException exceptionWithName:@"NullParameterException"
                                   reason:INVALID_PARAMETER_NULL
                                 userInfo:nil];
}

- (NSException *)invalidParameterSizeException {
    return [NSException exceptionWithName:@"InvalidParameterSizeException"
                                   reason:INVALID_PARAMETER_SIZE
                                 userInfo:nil];
}

- (NSException *)wrongTypeParameterException {
    return [NSException exceptionWithName:@"WrongTypeParameterException"
                                   reason:INVALID_PARAMETER_WRONG_TYPE
                                 userInfo:nil];
}

- (NSException *)invalidArgumentException {
    return [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:NS_INVALID_ARGUMENT_EXCEPTION
                                 userInfo:nil];
}

- (NSException *)invalidArgumentFormatException {
    return [NSException exceptionWithName:@"InvalidArgumentFormatException"
                                   reason:INVALID_PARAMETER_WRONG_FORMAT
                                 userInfo:nil];
}

+ (NSString *)pluginExceptionHandler:(NSException *)exception {
    NSString *errorMessage = [NSString stringWithFormat:@"\nDID Plugin Exception type :%@\nDID Plugin Exception reason :%@",exception.name,exception.reason];
    NSLog(@"%@", errorMessage);
    return errorMessage;
    
}

@end

