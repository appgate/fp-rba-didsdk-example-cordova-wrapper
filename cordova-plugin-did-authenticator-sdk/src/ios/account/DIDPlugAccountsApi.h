#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>
#import "DetectIDCordovaPlugin.h"

@interface DIDPlugAccountsApi: CDVPlugin

- (void)getAccounts:(CDVInvokedUrlCommand*) command;

- (void)removeAccount:(CDVInvokedUrlCommand*) command;

- (void)setAccountUsername:(CDVInvokedUrlCommand*) command;

@end
