
#import "N2Ui.h"
#import "N2View.h"
#import "core/N2Objc.h"

@interface N2ViewImplementation : UIView

@end

N2UI_BEGIN

View::View()
{
    N2ViewImplementation* o = [[N2ViewImplementation alloc] init];
    bindMeta(o);
    SAFE_RELEASE(o);
}

View::~View()
{
    
}

void View::hide(bool b)
{
    [getMeta() setHidden:b];
}

bool View::ishidden() const
{
    return [getMeta() isHidden];
}

void View::visible(bool b)
{
    hide(!b);
}

bool View::isvisibled() const
{
    return !ishidden();
}

N2UI_END

@implementation N2ViewImplementation

@end
