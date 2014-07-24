
extension UILabel
{

}

class Label : UILabel, SignalSlotPattern
{
    func signals() -> Signals
    {
        return SignalSlotImpl.signals(self)
    }
    
    func siginit()
    {
        
    }
}

extension UIButton
{

}

class Button : UIButton, SignalSlotPattern
{
    func signals() -> Signals
    {
        return SignalSlotImpl.signals(self)
    }
    
    func siginit()
    {
        self.addTarget(self, action: Selector("__act_clicked"), forControlEvents: UIControlEvents.TouchDown)
        self.signals().add(kSignalClicked)
    }
    
    final
    func __act_clicked()
    {
        self.signals().emit(kSignalClicked)
    }
    
}
