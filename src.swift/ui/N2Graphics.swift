
struct CGPadding
{
    init(t:CGFloat, b:CGFloat, l:CGFloat, r:CGFloat)
    {
        self.left = l
        self.right = r
        self.top = t
        self.bottom = b
    }
    
    var left:CGFloat, right:CGFloat, bottom:CGFloat, top:CGFloat
    
    var width: CGFloat
    {
    return self.left + self.right
    }
    
    var height: CGFloat
    {
    return self.top + self.bottom
    }
    
    static var zeroPadding: CGPadding
    {
        return CGPadding(t:0, b:0, l:0, r:0)
    }
}

protocol CGRectExt
{
    mutating func apply(pad:CGPadding) -> CGRect
    mutating func offset(pt:CGPoint) -> CGRect
}

extension CGRect : CGRectExt
{
    mutating func apply(pad:CGPadding) -> CGRect
    {
        self.size.width -= pad.width
        self.size.height -= pad.height
        self.origin.x += pad.left
        self.origin.y += pad.top
        return self
    }
    
    mutating func offset(pt:CGPoint) -> CGRect
    {
        self.origin.x += pt.x
        self.origin.y += pt.y
        return self
    }
}
