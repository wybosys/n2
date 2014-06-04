
import n2ui
import UIKit

@UIApplicationMain
class AppDelegate: Application, UIApplicationDelegate
{
    override func load()
    {
        let sample = VCSample()
        self.root.pushViewController(sample, animated: true)
    }
}
