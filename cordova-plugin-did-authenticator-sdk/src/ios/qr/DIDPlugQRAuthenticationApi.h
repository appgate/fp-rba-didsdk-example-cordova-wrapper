#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <didm_sdk/didm_sdk.h>
#import "DetectIDCordovaPlugin.h"

@interface DIDPlugQRAuthenticationApi: CDVPlugin<QRCodeScanTransactionDelegate, QRCodeTransactionServerResponseDelegate, QRCodeTransactionActionDelegate, UIAlertViewDelegate>

- (void)qrAuthenticationProcess:(CDVInvokedUrlCommand*)command;
- (void)confirmQRCodeTransaction:(CDVInvokedUrlCommand*)command;
- (void)declineQRCodeTransaction:(CDVInvokedUrlCommand*)command;

// QRCodeScanTransactionDelegate
- (void)onQRCodeScanTransaction:(TransactionInfo *)transaction;

// QRCodeTransactionServerResponseDelegate
- (void)onQRCodeTransactionServerResponse:(NSString *)response;

// QRCodeTransactionActionDelegate
- (void)onConfirmQRCodeTransaction:(TransactionInfo *)transaction;
- (void)onDeclineQRCodeTransaction:(TransactionInfo *)transaction;

@end
