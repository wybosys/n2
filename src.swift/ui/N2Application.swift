
import n2core

class Application : UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var root: UINavigationController!
    
    func bootstrap() -> Bool {
        return true
    }
    
    func start() {
        self.root = UINavigationController()
        self.root.navigationBarHidden = true
    }
    
    func load() {
        
    }
    
    @final
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool
    {
        // 初始化基础架构
        n2_core_foundation()
        
        // 引导应用
        if !self.bootstrap() {
            return false
        }
        
        // 初始化环境
        self.start()
        
        // 建立根window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.rootViewController = self.root
        self.window!.makeKeyAndVisible()
        
        // 加载应用
        self.load()
        
        return true
    }
    
    @final
    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    @final
    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    @final
    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    @final
    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    @final
    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
