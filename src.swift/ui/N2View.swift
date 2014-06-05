
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
    
    var paddingEdge: CGPadding = CGPadding.zeroPadding
    var offsetEdge: CGPoint = CGPoint.zeroPoint
    
    @final
    override func layoutSubviews()
    {
        var rc = self.rectForLayout()
        self.onlayout(rc)
    }
    
    func onlayout(rect: CGRect)
    {
        
    }
    
    func rectForLayout() -> CGRect
    {
        var ret = self.bounds
        ret.apply(self.paddingEdge)
        ret.offset(self.offsetEdge)
        return ret
    }
    
}
