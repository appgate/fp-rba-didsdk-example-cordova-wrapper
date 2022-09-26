#import <Foundation/Foundation.h>

@interface DIDPlugExceptionsHelper : NSObject
@property (nonatomic,strong) NSException *nullParameterException;
@property (nonatomic,strong) NSException *invalidParameterSizeException;
@property (nonatomic,strong) NSException *wrongTypeParameterException;
@property (nonatomic,strong) NSException *invalidArgumentFormatException;
@property (nonatomic,strong) NSException *invalidArgumentException;

+ (NSString *)pluginExceptionHandler:(NSException *)exception;

@end

