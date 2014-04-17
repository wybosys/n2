
#import "ui/N2Ui.h"
#import "N2ViewController.h"

@interface N2ViewControllerImplementation : UIViewController

@end

N2UI_BEGIN

ViewController::ViewController()
{
    N2ViewControllerImplementation* o = [[N2ViewControllerImplementation alloc] init];
    bindMeta(o);
    SAFE_RELEASE(o);
}

ViewController::~ViewController()
{
    
}

N2UI_END

@implementation N2ViewControllerImplementation

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    SUPER_DEALLOC;
}

@end
