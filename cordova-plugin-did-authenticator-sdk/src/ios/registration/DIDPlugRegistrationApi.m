#import "DIDPlugServerHelper.h"
#import "DIDPlugRegexHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugRegistrationApi.h"
#import "DIDPlugConstantsHelper.h"
#import <Cordova/CDVViewController.h>

@implementation DIDPlugRegistrationApi
{
    __block DIDPlugRegistrationApi* pluginManager;
}
    
- (instancetype)init {
    if (self == [super init]){
    }
    return self;
}
      
- (void)didInit:(CDVInvokedUrlCommand*)command {
    [self didInitManager: command];
}

- (void)didRegistration:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground: ^{
        [self didRegistrationManager: command];
    }];
}
    
- (void)didRegistrationByQRCode:(CDVInvokedUrlCommand*)command {
    [self didRegistrationByQRCodeManager: command];
}
    
- (void)setRegistrationViewProperties:(CDVInvokedUrlCommand*)command {
    [self setRegistrationViewPropertiesManager:command];
}
    
- (void)didInitManager:(CDVInvokedUrlCommand*)command {
    __block DIDPlugRegistrationApi* pluginBlock = self;
    
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        [self validateInputParams: [NSDictionary class] withSize: 0 withCommand: command completion: ^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                [[DetectID sdk] didInit];
                
                pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
                [pluginBlock.commandDelegate sendPluginResult: pluginResult callbackId: commandBlock.callbackId];
                NSLog(SUCCESS_PROCESS);
            }
        }];
    } @catch (NSException *e) {
        [self handleException:e withBlock:pluginBlock andCommand:command];
    }
}

- (void)didRegistrationManager:(CDVInvokedUrlCommand *)command {
    __block DIDPlugRegistrationApi *pluginBlock = self;
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        self.myCallbackId = command.callbackId;
        
        DIDPlugRegistrationApi * __weak weakSelf = self;
        [self validateInputParams: [NSDictionary class] withSize: 1 withCommand: command completion: ^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                NSString *url = [[commandBlock.arguments objectAtIndex:0] valueForKeyPath:URL_KEY];
                if ([weakSelf validateNullString: url]) {
                    @throw [[DIDPlugExceptionsHelper new] nullParameterException];
                } else {
                    [pluginResult setKeepCallbackAsBool: NO];
                    [[DetectID sdk] didRegistrationWithUrl:url onSuccess:^{
                        CDVPluginResult *pluginResultSuccess = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: @"OK"];
                        [pluginBlock.commandDelegate sendPluginResult:pluginResultSuccess callbackId:command.callbackId];

                    } onFailure:^(AGSDKError *e) {
                        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsInt: ((int) ((NSError *)e).code)];
                        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
                    }];
                }
            }
        }];
    } @catch (NSException *e){
        [self handleException:e withBlock:pluginBlock andCommand:command];
    }
}
    
- (void)didRegistrationByQRCodeManager:(CDVInvokedUrlCommand*)command {
    __block DIDPlugRegistrationApi *pluginBlock = self;
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        self.myCallbackId = command.callbackId;

        [self validateInputParams: [NSDictionary class] withSize: 1 withCommand: command completion: ^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                NSString *code = [[commandBlock.arguments objectAtIndex:0] valueForKeyPath:DATA_KEY];
                [pluginResult setKeepCallbackAsBool: NO];
                [[DetectID sdk] didRegistrationByQRCode:code fromUrl:@"" onSuccess:^{
                    CDVPluginResult *pluginResultSuccess = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: @"OK"];
                    [pluginBlock.commandDelegate sendPluginResult:pluginResultSuccess callbackId:command.callbackId];
                } onFailure:^(AGSDKError * error) {
                    CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsInt: ((int) ((NSError *)error).code)];
                    [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
                }];
            }
        }];
    } @catch (NSException *e){
        [self handleException:e withBlock:pluginBlock andCommand:command];
    }
}
    

- (CDVPluginResult*)onRegistrationResponseManager:(NSString *)result withCommand:(CDVInvokedUrlCommand *)commandDeviceRegistrationServerResponseListener {
    CDVPluginResult *pluginResult = nil;
    
    if (commandDeviceRegistrationServerResponseListener != nil) {
        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: result];
        NSLog(SUCCESS_PROCESS);
    } else {
        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString: ERROR_REGISTRATION_RESPONSE_DELEGATE_NULL];
        NSLog(ERROR_REGISTRATION_RESPONSE_DELEGATE_NULL);
    }
    
    return pluginResult;
}
    
- (void)setRegistrationViewPropertiesManager:(CDVInvokedUrlCommand*)command {
    __block DIDPlugRegistrationApi* pluginBlock = self;
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        [self validateInputParams: [NSString class] withSize: 1 withCommand: command completion: ^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                if ([DIDPlugRegexHelper validateStringFormat: [commandBlock.arguments objectAtIndex: 0] withPattern: regitrationViewPropertiesRegex]) {
                    NSError *jsonError;
                    NSData *objectData = [[commandBlock.arguments objectAtIndex: 0] dataUsingEncoding: NSUTF8StringEncoding];
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData: objectData
                                                                         options: NSJSONReadingMutableContainers
                                                                           error: &jsonError];
                    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
                    [pluginBlock.commandDelegate sendPluginResult: pluginResult callbackId: commandBlock.callbackId];
                    NSLog(SUCCESS_PROCESS);
                } else {
                    @throw [[DIDPlugExceptionsHelper new] invalidArgumentFormatException];
                }
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}
    
    
- (void)validateInputParams:(Class) aClass withSize:(NSUInteger) size withCommand:(CDVInvokedUrlCommand*)command completion:(void (^)(NSException *exception)) completion {
    if (command.arguments) {
        if ([command.arguments count] == size) {
            if (size > 0) {
                id myarg = [command.arguments objectAtIndex:0];
                if ([myarg isKindOfClass:aClass]) {
                    completion(nil);
                } else {
                    completion([[DIDPlugExceptionsHelper new] wrongTypeParameterException]);
                }
            } else {
                completion(nil);
            }
        } else {
            completion([[DIDPlugExceptionsHelper new] invalidParameterSizeException]);
        }
    }else {
        completion([[DIDPlugExceptionsHelper new] nullParameterException]);
    }
}
    
- (BOOL)validateNullString:(NSString *) string {
    return [string isEqual:@"null"] || [string isEqual:[NSNull null]] || string ==nil;
}

- (void)handleException:(NSException*)e withBlock:(DIDPlugRegistrationApi*)pluginBlock andCommand:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
    [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
}

@end
