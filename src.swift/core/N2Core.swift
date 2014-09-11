
import Foundation

func n2_core_foundation()
{
}

protocol ObjectExt
{
    func oninit()
    func onfin()
}

class Object : NSObject, ObjectExt
{
    override init()
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
    return cls
}

let kSignalValueChanging = "::core::value::changing"
let kSignalValueChanged = "::core::value::changed"
let kSignalSelectionChanging = "::core::selection::changing"
let kSignalSelectionChanged = "::core::selection::changed"
