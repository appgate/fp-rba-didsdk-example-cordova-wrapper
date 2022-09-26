#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>

@interface DetectIDCordovaPlugin : CDVPlugin

// Executes all queued events
#pragma - mark - Common Api

- (void)didInit:(CDVInvokedUrlCommand*)command;

- (void)didRegistration:(CDVInvokedUrlCommand*)command;

- (void)didRegistrationByQRCode:(CDVInvokedUrlCommand*)command;

- (void)setRegistrationViewProperties:(CDVInvokedUrlCommand*)command;

@end
