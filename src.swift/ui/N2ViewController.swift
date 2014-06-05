
import n2core

class ViewController : UIViewController, NSObjectExt
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
    
    override func loadView()
    {
        if self.classForView {
            self.view = self.classForView!.`new`() as UIView
        } else {
            self.view = View()
        }
    }
    
}
