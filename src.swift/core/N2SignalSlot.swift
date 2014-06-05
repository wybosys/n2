
import Foundation

typealias SSignal = String

class Slot : NSObject, NSCopying
{
    // 源 slot
    var origin: Slot?
    
    // emit 次数上线，当 count == 0 时会被断开与 signal 的连接，默认为不限制 -1
    var count: Int = -1
    
    // 重新定向到的 signal
    // 当本 slot 激活时，将会重定向激活 target 上的该信号
    var redirect: SSignal?
    
    // 回调、重定向等依赖的目标对象
    weak var target: AnyObject?
    
    // 回调用的 sel
    var selector: Selector?
    
    // 回调用的 closure
    typealias cb_closure = (slot:Slot) -> Void
    var closure: cb_closure?
    
    // 传递的数据
    var data: AnyObject?
    
    // 发送者
    weak var sender: AnyObject?
    
    // 激活这个slot运行
    func emit()
    {
        if self.target && self.selector
        {
            
        }
        else if self.closure
        {
            self.closure!(slot:self)
        }
    }
    
    // 复制
    func copyWithZone(zone: NSZone) -> AnyObject!
    {
        var ret = Slot()
        ret.origin = self
        ret.redirect = self.redirect
        ret.selector = self.selector
        ret.closure = self.closure
        return ret
    }
}

class Slots : NSObject, NSCopying
{
    var _slots = Slot[]()
    
    func add(slot: Slot!)
    {
        self._slots.append(slot)
    }
    
    func clear()
    {
        self._slots.removeAll()
    }
    
    func find(sel: Selector!, target: AnyObject!) -> Slot?
    {
        return nil
    }
    
    // 复制
    func copyWithZone(zone: NSZone) -> AnyObject!
    {
        var ret = Slots()
        ret._slots = self._slots.copy()
        return ret
    }
}

class Signals
{
    var _sigslots = Dictionary<SSignal, Slots>()
    weak var _owner: AnyObject?
    
    func add(signal: SSignal!)
    {
        var arr = self._sigslots[signal]
        if arr === nil
        {
            arr = Slots()
            self._sigslots[signal] = arr
        }
    }
    
    func exist(signal: SSignal!) -> Bool
    {
        return self._sigslots[signal] !== nil
    }
    
    func connect(signal: SSignal!, sel: Selector!, target: AnyObject!)
    {
        if var ss = self._sigslots[signal]
        {
            var s = Slot()
            s.target = target
            s.selector = sel
            ss.add(s)
        }
    }
    
    func connect(signal: SSignal!, cbb: (slot:Slot) -> Void)
    {
        if var ss = self._sigslots[signal]
        {
            var s = Slot()
            s.closure = cbb
            ss.add(s)
        }
    }
    
    func emit(signal: SSignal!)
    {
        if var ss = self._sigslots[signal]
        {
            // 遍历信号
            for slot in ss._slots
            {
                slot.sender = self
                
                // 激活
                slot.emit()
            }
        }
    }
}

var __nsobj_dynamickey_signals: Void?

protocol SignalSlotPattern
{
    func signals() -> Signals
    func siginit()
}

struct SignalSlotImpl
{
    static func signals(obj: AnyObject!) -> Signals
    {
        var ret = objc_getAssociatedObject(obj, &__nsobj_dynamickey_signals) as Signals
        if ret === nil
        {
            ret = Signals()
            ret._owner = obj
            objc_setAssociatedObject(obj, &__nsobj_dynamickey_signals, ret, OBJC_ASSOCIATION_RETAIN_NONATOMIC.asUnsigned())
            //NSObject.performSelector(Selector("siginit"), onThread: NSThread.currentThread(), withObject: nil, waitUntilDone: true)
        }
        return ret as Signals
    }
}
