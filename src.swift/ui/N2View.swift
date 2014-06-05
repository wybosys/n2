
import n2core

class View : UIView, NSObjectExt
{
    convenience init()
    {
        self.init(frame: CGRect.zeroRect)
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
}
