
#import "N2Ui.h"
#import "N2View.h"
#import "core/N2Objc.h"
#import "N2Swizzle.h"

PERFORM_STATIC(UIKitSwizzle, Swizzles);

@interface UIView (n2ext)

@end

@interface N2View : UIView

@end

N2UI_BEGIN

View::View()
{
    N2View* o = [[N2View alloc] initWithFrame:CGRectZero];
    bindMeta(o);
    OBJC_RELEASE(o);
}

View::~View()
{
    
}

void View::hide(bool b)
{
    [meta() setHidden:b];
}

bool View::ishidden() const
{
    return [meta() isHidden];
}

void View::visible(bool b)
{
    hide(!b);
}

bool View::isvisibled() const
{
    return !ishidden();
}

void View::background(Color const& c)
{
    [meta() setBackgroundColor:c];
}

Color View::backgroundColor() const
{
    return [meta() backgroundColor];
}

void View::onLayout(Rect const&)
{
    PASS;
}

void View::frame(Rect const& rc)
{
    [meta() setFrame:rc];
}

Rect View::frame() const
{
    return [meta() frame];
}

Rect View::bounds() const
{
    return [meta() bounds];
}

void View::add(View& v)
{
    [meta() addSubview:v];
}

Rect View::boundsForLayout() const
{
    Rect rc = bounds();
    return rc;
}

Control::Control()
{
    
}

Control::~Control()
{
    
}

void Control::enable(bool b)
{
    meta<UIControl>().enabled = b;
}

bool Control::isenabled() const
{
    return meta<UIControl>().enabled;
}

void Control::select(bool b)
{
    meta<UIControl>().enabled = b;
}

bool Control::isselected() const
{
    return meta<UIControl>().selected;
}

void Control::highlight(bool b)
{
    meta<UIControl>().highlighted = b;
}

bool Control::ishighlighted() const
{
    return meta<UIControl>().highlighted;
}

N2UI_END

@implementation N2View

- (id)init {
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end

@implementation UIView (n2ext)

- (void)SWIZZLE_CALLBACK(layout_subviews) {
    N2UI_USE;
    View* v = MetaObject::GetObject<View>(self);
    if (v)
        v->onLayout(v->boundsForLayout());
}

@end
