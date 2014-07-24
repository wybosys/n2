
class Application : UIResponder, UIApplicationDelegate, SignalSlotPattern
{
    var window: UIWindow?
    var root: UINavigationController!
    
    func bootstrap() -> Bool
    {
        n2_core_foundation()
        
        // 替换一些标准类的函数
        uikit_swizzles()
        
        return true
    }
    
    func start()
    {
        self.root = UINavigationController()
        self.root.navigationBarHidden = true
    }
    
    func load()
    {
        
    }
    
    final
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool
    {        
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
    
    final
    func applicationWillResignActive(application: UIApplication)
    {
        log("Application Deactivating")
        self.signals().emit(kSignalApplicationDeactivating)
    }
    
    final
    func applicationDidEnterBackground(application: UIApplication)
    {
        log("Application Deactivated")
        self.signals().emit(kSignalApplicationDeactivated)
    }
    
    final
    func applicationWillEnterForeground(application: UIApplication)
    {
        log("Application Activating")
        self.signals().emit(kSignalApplicationActivating)
    }
    
    final
    func applicationDidBecomeActive(application: UIApplication)
    {
        log("Application Activated")
        self.signals().emit(kSignalApplicationActivated)
    }
    
    final
    func applicationWillTerminate(application: UIApplication)
    {
        log("terminating")
    }
    
    func signals() -> Signals
    {
        return SignalSlotImpl.signals(self)
    }
    
    func siginit()
    {
        self.signals().add(kSignalApplicationActivating)
        self.signals().add(kSignalApplicationActivated)
        self.signals().add(kSignalApplicationDeactivating)
        self.signals().add(kSignalApplicationDeactivated)
    }
}

let kSignalApplicationActivating = "::ui::app::activating";
let kSignalApplicationActivated = "::ui::app::activated";
let kSignalApplicationDeactivating = "::ui::app::deactivating";
let kSignalApplicationDeactivated = "::ui::app::deactivated";
