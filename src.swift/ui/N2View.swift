
protocol UIViewExt
{
    
}

extension UIView : UIViewExt
{
    
}

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
    
    // 边缘的留空
    var paddingEdge: CGPadding = CGPadding.zeroPadding
    
    // 内容的偏移
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
