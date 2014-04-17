
#import "N2Ui.h"
#import "N2ViewController.h"
#import "N2Swizzle.h"

@interface N2ViewController : UIViewController

@end

N2UI_BEGIN

ViewController::ViewController()
{
    N2ViewController* o = [[N2ViewController alloc] init];
    bindMeta(o);
    SAFE_RELEASE(o);
}

ViewController::ViewController(metapointer_t o)
{
    bindMeta(o);
}

ViewController::~ViewController()
{
    
}

void ViewController::loadView()
{
    PASS;
}

View& ViewController::view()
{
    return _view;
}

void ViewController::onLoaded()
{
    PASS;
}

N2UI_END

@implementation N2ViewController

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    SUPER_DEALLOC;
}

- (void)loadView {
    N2UI_USE;
    
    ViewController* vc = MetaObject::GetObject<ViewController>(self);
    vc->loadView();
    
    if (self.isViewLoaded == NO)
        [super loadView];
}

- (void)SWIZZLE_CALLBACK(view_loaded) {
    N2UI_USE;
    ViewController* navi = MetaObject::GetObject<ViewController>(self);
    navi->onLoaded();
}

@end
