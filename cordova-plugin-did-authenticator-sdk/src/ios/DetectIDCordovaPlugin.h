#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>

@interface DetectIDCordovaPlugin : CDVPlugin

- (void)didRegistration:(CDVInvokedUrlCommand*)command;

- (void)didRegistrationByQRCode:(CDVInvokedUrlCommand*)command;

- (void)setRegistrationViewProperties:(CDVInvokedUrlCommand*)command;

@end
