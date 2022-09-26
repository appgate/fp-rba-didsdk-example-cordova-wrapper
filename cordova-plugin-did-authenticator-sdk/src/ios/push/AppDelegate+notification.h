#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <didm_sdk/didm_sdk.h>

@interface AppDelegate (notification) <UNUserNotificationCenterDelegate, PushTransactionOpenDelegate, PushAlertOpenDelegate>

@property (nonatomic, retain) NSDictionary *launchNotification;

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UNUserNotificationCenter *)notificationSettings;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)(void))completionHandler;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (id)getCommandInstance:(NSString*)className;

@end
