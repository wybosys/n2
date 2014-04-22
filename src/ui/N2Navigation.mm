
#import "N2Ui.h"
#import "N2Navigation.h"
#import "N2Swizzle.h"

@interface N2NavigationController : UINavigationController

@end

N2UI_BEGIN

NavigationBar::NavigationBar()
: View(nil)
{
    
}

NavigationBar::~NavigationBar()
{
    
}

void NavigationBar::hide(bool b)
{
    [navigation->meta() setNavigationBarHidden:b];
}

void NavigationBar::hide(bool b, bool ani)
{
    [navigation->meta() setNavigationBarHidden:b animated:ani];
}

Navigation::Navigation()
: ViewController(nil)
{
    N2NavigationController* o = [[N2NavigationController alloc] init];
    bindMeta(o);
    OBJC_RELEASE(o);
    
    bar.bindMeta(o.navigationBar);
    bar.navigation = this;
}

Navigation::~Navigation()
{
    
}

void Navigation::push(ViewController& vc, bool ani)
{
    [meta() pushViewController:vc animated:ani];
}

void Navigation::pop(bool ani)
{
    [meta() popViewControllerAnimated:ani];
}

N2UI_END

@implementation N2NavigationController

- (void)SWIZZLE_CALLBACK(view_loaded) {
    N2UI_USE;
    Navigation* navi = MetaObject::GetObject<Navigation>(self);
    navi->onLoaded();
}

@end
