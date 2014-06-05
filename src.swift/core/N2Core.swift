
import Foundation

func n2_core_foundation()
{
}

protocol NSObjectExt
{
    func oninit()
    func onfin()
}

class Object : NSObject, NSObjectExt
{
    init()
    {
        super.init()
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

func type(cls:AnyClass!) -> AnyClass
{
    return cls;
}
