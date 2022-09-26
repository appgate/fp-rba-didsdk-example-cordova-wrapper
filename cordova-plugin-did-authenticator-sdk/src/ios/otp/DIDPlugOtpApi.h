#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>
#import "DetectIDCordovaPlugin.h"

@interface DIDPlugOtpApi: CDVPlugin

- (void)updateGlobalConfig:(CDVInvokedUrlCommand*)command;
- (void)getTokenValue:(CDVInvokedUrlCommand*)command;
- (void)getChallengeTokenValue:(CDVInvokedUrlCommand*)command;

@end
