
import Foundation

class Slot : NSObject
{
    
}

class Slots : NSObject
{
    
}

class Signals : NSObject
{
    
}

var __nsobj_dynamickey_signals: CConstVoidPointer?

extension NSObject
{
    func signals() -> Signals
    {
        var ret:AnyObject = objc_getAssociatedObject(self, &__nsobj_dynamickey_signals)
        if ret === nil {
            ret = Signals()
            objc_setAssociatedObject(self, &__nsobj_dynamickey_signals, ret, OBJC_ASSOCIATION_RETAIN_NONATOMIC.asUnsigned())
        }
        return ret as Signals
    }
    
}
