
class ViewController : UIViewController, ObjectExt
{
    var classForView: AnyClass?
    
    convenience init()
    {
        self.init(coder: nil)
        self.oninit()
    }
    
    deinit
    {
        self.onfin()
    }
    
    func oninit()
    {
        
    }
    
    func onfin()
    {
        
    }
    
    @final
    override func loadView()
    {
        if self.classForView
        {
            self.view = self.classForView!.`new`() as UIView
        }
        else
        {
            self.view = View()
        }
    }
    
    @final
    override func viewDidLoad()
    {
        self.onloaded()
    }
    
    func onloaded()
    {
        
    }
    
}
