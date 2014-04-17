
#import "N2Ui.h"
#import "N2View.h"
#import "core/N2Objc.h"
#import "N2Swizzle.h"

PERFORM_STATIC(UIKitSwizzle, Swizzles);

@interface N2View : UIView

@end

N2UI_BEGIN

View::View()
{
    N2View* o = [[N2View alloc] init];
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

@implementation N2View

- (id)init {
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)SWIZZLE_CALLBACK(layout_subviews) {
    
}

@end
