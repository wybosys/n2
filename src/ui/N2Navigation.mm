
#import "N2Ui.h"
#import "N2Navigation.h"
#import "N2Swizzle.h"

@interface N2NavigationController : UINavigationController

@end

N2UI_BEGIN

NavigationBar::NavigationBar()
{
    
}

Navigation::Navigation()
: ViewController(nil)
{
    N2NavigationController* o = [[N2NavigationController alloc] init];
    bindMeta(o);
    SAFE_RELEASE(o);
}

Navigation::~Navigation()
{
    
}

void Navigation::push(ViewController& vc, bool ani)
{
    [getMeta() pushViewController:vc animated:ani];
}

void Navigation::pop(bool ani)
{
    [getMeta() popViewControllerAnimated:ani];
}

N2UI_END

@implementation N2NavigationController

- (void)SWIZZLE_CALLBACK(view_loaded) {
    N2UI_USE;
    Navigation* navi = MetaObject::GetObject<Navigation>(self);
    navi->onLoaded();
}

@end
