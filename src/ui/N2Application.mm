
#import "core/N2Core.h"
#import "N2Ui.h"
#import "N2Application.h"
#import "core/N2Objc.h"

@interface N2AppImplementation : NSObject <UIApplicationDelegate>

@end

N2UI_BEGIN

PRIVATE_IMPL(Application)

void init()
{
    gs_App = d_owner;
}

void fin()
{
    
}

static Application* gs_App;

PRIVATE_END

Application* PRIVATE_CLASS(Application)::gs_App = NULL;

Application::Application()
{
    PRIVATE_CONSTRUCT;
}

Application::~Application()
{
    PRIVATE_DESTROY;
}

int Application::execute()
{
    return execute(0, NULL);
}

int Application::execute(int argc, char** argv)
{
    int ret = 0;
    @autoreleasepool
    {
        try
        {
            @try
            {
                ret = UIApplicationMain(argc, argv, nil, @"N2AppImplementation");
            }
            @catch (NSException* exp)
            {
                FATAL(exp.reason.UTF8String);
            }
        }
        catch (...)
        {
            FATAL("捕获未知异常");
        }
    }
    return ret;
}

Application& Application::shared()
{
    return *PRIVATE_CLASS(Application)::gs_App;
}

bool Application::bootstrap()
{
    return YES;
}

void Application::load()
{
    PASS;
}

N2UI_END

@implementation N2AppImplementation

- (id)init {
    self = [super init];
    return self;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    PASS;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    API_IOS6
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化objc环境
    n2_objc_foundation();
    
    // 加载应用
    N2UI_USE;
    
    Application& rapp = Application::shared();
    if (!rapp.bootstrap()) {
        FATAL("应用初始化失败");
        return NO;
    }
    
    // 加载应用
    rapp.load();
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
    
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

/*
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    API_IOS7
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    API_IOS7;
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    API_IOS7;
}
 */

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    
}

/*
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    API_IOS6
    return UIInterfaceOrientationMaskAll;
}

- (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    API_IOS6
    return nil;
}

- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    API_IOS6
}

- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    API_IOS6
}

- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    API_IOS6
}

- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    API_IOS6
}
 */

@end
