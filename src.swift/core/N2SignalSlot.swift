
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
    weak var target: NSObject?
    
    // 回调用的 sel
    var selector: Selector?
    
    // 回调用的 closure
    typealias cb_closure = (slot:Slot) -> Void
    var closure: cb_closure?
    
    // 传递的数据
    var data: AnyObject?
    
    // 发送者
    weak var sender: NSObject?
    
    // 激活这个slot运行
    func emit()
    {
        if self.target != nil &&
            self.selector != nil
        {
            self.target!.invokeSelector(self.selector!, withObject:nil)
        }
        else if self.closure != nil
        {
            self.closure!(slot:self)
        }
    }
    
    // 复制
    func copyWithZone(zone: NSZone) -> AnyObject
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
    var _slots:[Slot] = []
    
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
    func copyWithZone(zone: NSZone) -> AnyObject
    {
        var ret = Slots()
        ret._slots = self._slots
        return ret
    }
}

class Signals
{
    var _sigslots = Dictionary<SSignal, Slots>()
    weak var _owner: NSObject?
    
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
    
    func connect(signal: SSignal!, sel: Selector!, target: NSObject!)
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
                slot.sender = self._owner
                
                // 激活
                slot.emit()
            }
        }
    }
}

protocol SignalSlotPattern
{
    func signals() -> Signals
    func siginit()
}

struct SignalSlotImpl
{
    static func signals(obj: NSObject!) -> Signals
    {
        if obj._inner_signals === nil {
            obj._inner_signals = Signals()
            obj.invokeSelector(Selector("siginit"), withObject:nil)
        }
        return obj._inner_signals as Signals
    }
}
