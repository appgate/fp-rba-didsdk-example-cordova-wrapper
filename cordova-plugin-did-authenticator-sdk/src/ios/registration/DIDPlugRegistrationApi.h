#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>
#import "DIDPlugServerHelper.h"
#import "DetectIDCordovaPlugin.h"

@interface DIDPlugRegistrationApi : CDVPlugin

@property (nonatomic,strong) __block CDVInvokedUrlCommand *commandDeviceRegistrationServerResponseListener;
@property (nonatomic, retain) CDVInvokedUrlCommand *currentCommand;
@property (nonatomic, strong) NSString* myCallbackId;

- (void)didInit:(CDVInvokedUrlCommand*)command;

- (void)didRegistration:(CDVInvokedUrlCommand*)command;

- (void)didRegistrationByQRCode:(CDVInvokedUrlCommand*)command;

- (void)setRegistrationViewProperties:(CDVInvokedUrlCommand*)command;

- (void)onRegistrationResponse:(NSString*)result;

- (CDVPluginResult*)onRegistrationResponseManager:(NSString *)result withCommand:(CDVInvokedUrlCommand *)commandDeviceRegistrationServerResponseListener;

@end

