
import n2core
import n2ui

class VSample : View
{
    override func oninit()
    {
        super.oninit()

        self.btnTest.setTitle("TEST", forState: UIControlState.Normal)
        self.btnTest.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.addSubview(self.btnTest)
    }
    
    override func onlayout(rect: CGRect)
    {
        super.onlayout(rect)
        self.btnTest.frame = rect
    }
    
    let btnTest = Button()
}

class VCSample : ViewController
{
    override func oninit()
    {
        super.oninit()
        self.classForView = type(VSample)
    }
}
