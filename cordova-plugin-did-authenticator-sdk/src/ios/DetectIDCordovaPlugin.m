#import "DetectIDCordovaPlugin.h"
#import <Availability.h>
#import "DIDPlugRegexHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugServerHelper.h"
#import "DIDPlugRegistrationApi.h"


@interface DetectIDCordovaPlugin ()

// Retrieves the application state
@property (readonly, getter=applicationState) NSString* applicationState;
// All events will be queued until deviceready has been fired
@property (readwrite, assign) BOOL deviceready;
// Event queue
@property (readonly, nonatomic, retain) NSMutableArray* eventQueue;

@end

@implementation DetectIDCordovaPlugin
{
    __block DIDPlugRegistrationApi* pluginManager;
    __block CDVInvokedUrlCommand *commandDeviceRegistrationServerResponseListener;
}

@synthesize deviceready, eventQueue;

#pragma mark -
#pragma mark Interface

/**
 * Execute all queued events. TODO: PREGUNTAR ESTO QUE HACE
 */
- (void) deviceready:(CDVInvokedUrlCommand*)command
{
    deviceready = YES;
    
    for (NSString* js in eventQueue) {
        [self.commandDelegate evalJs:js];
    }
    
    [eventQueue removeAllObjects];
}

- (void)didInit:(CDVInvokedUrlCommand *)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    pluginManager = [DIDPlugRegistrationApi new];
    [pluginManager didInit: commandBlock];
}

- (void)deviceRegistrationByCode:(CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
        [self -> pluginManager didRegistration: commandBlock];
    }];
}

- (void)deviceRegistrationByQRCode:(CDVInvokedUrlCommand*)command {
    __block CDVInvokedUrlCommand *commandBlock = command;
    [pluginManager didRegistrationByQRCode: commandBlock];
}

-(void)onRegistrationResponse:(NSString*) result {
    commandDeviceRegistrationServerResponseListener = pluginManager.commandDeviceRegistrationServerResponseListener;
    [self.commandDelegate sendPluginResult:[pluginManager onRegistrationResponseManager:result withCommand:commandDeviceRegistrationServerResponseListener] callbackId:commandDeviceRegistrationServerResponseListener.callbackId];
}

- (void) setRegistrationViewProperties:(CDVInvokedUrlCommand*)command{
    [pluginManager setRegistrationViewProperties: command];
}

@end
