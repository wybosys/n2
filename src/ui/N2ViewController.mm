
#import "N2Ui.h"
#import "N2ViewController.h"
#import "N2Swizzle.h"

@interface UIViewController (n2ext)

@end

@interface N2ViewController : UIViewController

@end

N2UI_BEGIN

ViewController::ViewController()
{
    N2ViewController* o = [[N2ViewController alloc] init];
    bindMeta(o);
    OBJC_RELEASE(o);
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

void ViewController::title(String const& s)
{
    if (title() == s)
        return;
    [meta() setTitle:s];
    signals().emit(kSignalTitleChanged, s);
}

String ViewController::title() const
{
    return [meta() title];
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
    
    // 设置view
    if (vc->_view.isnull())
        [super loadView];
    else
        self.view = *vc->_view;
}

@end

@implementation UIViewController (n2ext)

- (void)SWIZZLE_CALLBACK(view_loaded) {
    N2UI_USE;
    ViewController* navi = MetaObject::GetObject<ViewController>(self);
    if (navi)
        navi->onLoaded();
}

@end
