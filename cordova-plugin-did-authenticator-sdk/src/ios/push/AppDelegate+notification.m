#import "AppDelegate+notification.h"
#import <objc/runtime.h>
#import <didm_sdk/didm_sdk.h>
#import "DIDPluginTransactionOpenListener.h"
#import "DIDPluginPushAlertOpenListener.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static char launchNotificationKey;

@implementation AppDelegate (notification)

- (id)getCommandInstance:(NSString*)className {
    return [self.viewController getCommandInstance: className];
}

+ (void)load {

}

- (void)createNotificationChecker:(NSDictionary *)launchOptions {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
        if(!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
            
        }
    }];
    
    [center setNotificationCategories:[[DetectID sdk] getUNNotificationActionCategoriesForNotificationsWithAcceptTitle:@"Confirm" andDeclineTitle:@"Decline"]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setPushDelegates];
    [self createNotificationChecker: launchOptions];
    
    return [super application: application didFinishLaunchingWithOptions: launchOptions];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UNUserNotificationCenter *)notificationSettings{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[DetectID sdk] receivePushServiceId:deviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{

}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setPushDelegates];
        [[DetectID sdk]subscribePayload:userInfo];
    });
}

// app background
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    [[DetectID sdk] handleActionWithIdentifier:response];
    completionHandler();
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)(void))completionHandler {
    [self setPushDelegates];
    [[DetectID sdk] handleActionWithIdentifier:identifier forNotification:userInfo];
    completionHandler();
}

// app open
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[DetectID sdk] subscribePayload:notification withCompletionHandler:completionHandler];
    });
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"active");
}

- (NSMutableArray *)launchNotification {
    return objc_getAssociatedObject(self, &launchNotificationKey);
}

- (void)setLaunchNotification:(NSDictionary *)aDictionary {
    objc_setAssociatedObject(self, &launchNotificationKey, aDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dealloc {
    self.launchNotification = nil;
}

- (void)setPushDelegates {
    [[[DetectID sdk] getPushApi] setPushTransactionOpenDelegate: self];
    [[[DetectID sdk] getPushApi] setPushAlertOpenDelegate: self];
}

- (void)onPushTransactionOpen:(TransactionInfo *)transaction {
    DIDPluginTransactionOpenListener* pluginTransactionOpen = [DIDPluginTransactionOpenListener sharedInstance];
    pluginTransactionOpen.transactionInfo = transaction;
}

- (void)onPushAlertOpen:(TransactionInfo *)transaction {
    DIDPluginPushAlertOpenListener* pluginAlertOpen = [DIDPluginPushAlertOpenListener sharedInstance];
    pluginAlertOpen.transactionInfo = transaction;
}

@end

