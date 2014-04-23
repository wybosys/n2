
#import "N2Ui.h"
#import "N2Application.h"
#import "core/N2Objc.h"
#import "N2Navigation.h"
#import "N2QC.h"

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
: window(nil)
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
                ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([N2AppImplementation class]));
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

void Application::start()
{
    root = RefInstance<Navigation>();
    root->bar.hide();
}

void Application::load()
{
    PASS;
}

void Application::bindWindow(metapointer_t o)
{
    window.bindMeta(o);
}

N2UI_END

@implementation N2AppImplementation

@synthesize window;

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
    
    // 标准设置
    if (!rapp.bootstrap()) {
        FATAL("应用初始化失败");
        return NO;
    }
    
    // 初始化环境
    rapp.start();
    
    // 建立根window
    UIWindow* win = [[NSClassFromString(@"N2Window") alloc] initWithFrame:kUIScreenBounds];
    self.window = win;;
    win.rootViewController = *rapp.root;
    [win makeKeyAndVisible];
    rapp.bindWindow(win);
    
    // 加载开发测试环境
#ifdef TRUEDEBUG_MODE
    N2QC::shared().launch();
#endif
    
    // 加载应用
    rapp.load();
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    LOG("Application Actived");
    
    N2UI_USE;
    Application::shared().signals().emit(kSignalApplicationActived);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    LOG("Application Deactiving");

    N2UI_USE;
    Application::shared().signals().emit(kSignalApplicationDeactiving);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    PASS;
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    LOG("Memory Warning");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    LOG("Terminating");
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
    PASS;
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    LOG("Orentation Chaning to:%d duration:%f", newStatusBarOrientation, duration);
    
    N2UI_USE;
    Application::shared().signals().emit(kSignalApplicationOrientationChanging, Number(newStatusBarOrientation));
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    LOG("Orentation Changed from:%d", oldStatusBarOrientation);
    
    N2UI_USE;
    Application::shared().signals().emit(kSignalApplicationOrientationChanged, Number(oldStatusBarOrientation));
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    PASS;
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    PASS;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PASS;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    PASS;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    PASS;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    PASS;
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
    LOG("Application Deactived");

    N2UI_USE;
    Application::shared().signals().emit(kSignalApplicationDeactived);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    LOG("Application Activing");

    N2UI_USE;
    Application::shared().signals().emit(kSignalApplicationActiving);
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    PASS;
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    PASS;
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
