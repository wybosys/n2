
import n2core
import n2ui

class VSample : View
{
    override func oninit()
    {
        super.oninit()
    }
    
    override func onlayout(rect: CGRect)
    {
        super.onlayout(rect)
    }
}

class VCSample : ViewController
{
    override func oninit()
    {
        super.oninit()
        self.classForView = type(VSample)
    }
}
