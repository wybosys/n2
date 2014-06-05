
class Console
{
    func logd(msg:String)
    {
        print("LOGd:")
        print(msg)
        println()
    }
}

var console = Console()

func log(msg:String!)
{
    console.logd(msg)
}
