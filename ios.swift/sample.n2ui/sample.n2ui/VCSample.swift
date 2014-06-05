
import n2core
import n2ui

class VSample : View
{
    override func oninit()
    {
        
    }
}

class VCSample : ViewController
{
    override func oninit()
    {
        self.classForView = type(VSample)
    }
}
