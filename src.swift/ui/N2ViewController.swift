
import UIKit

class ViewController : UIViewController
{
    var classForView: AnyClass?
    
    override func loadView()
    {
        if self.classForView {
            self.view = self.classForView!.`new`() as UIView
        } else {
            self.view = View()
        }
    }
    
}
