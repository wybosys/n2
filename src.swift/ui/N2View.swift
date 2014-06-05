
protocol IView
{
    func onlayout(rect:CGRect)
}

extension UIView
{
    func rectForLayout() -> CGRect
    {
        return self.bounds
    }
    
    @final
    func __swcb_layoutsubviews()
    {
        var rc = self.rectForLayout()
        if self.respondsToSelector(Selector("onlayout:")) {
            let sf:AnyObject = self
            sf.onlayout(rc)
        }
    }
}

class View : UIView, ObjectExt, IView
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
    
    // 边缘的留空
    var paddingEdge: CGPadding = CGPadding.zeroPadding
    
    // 内容的偏移
    var offsetEdge: CGPoint = CGPoint.zeroPoint
    
    override func rectForLayout() -> CGRect
    {
        var ret = self.bounds
        ret.apply(self.paddingEdge)
        ret.offset(self.offsetEdge)
        return ret
    }
    
    func onlayout(rect: CGRect)
    {
        
    }
}
