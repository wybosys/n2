
#import "N2Ui.h"
#import "N2View.h"
#import "core/N2Objc.h"
#import "N2Swizzle.h"

//const float kDurationLongTouch = .25f;
//const float kDurationDbTouchInterval = .2f;

PERFORM_STATIC(UIKitSwizzle, Swizzles);

@interface UIView (n2ext)

@end

@interface UIControl (n2ext)

- (void)cbTouchDown;
- (void)cbTouchDownRepeat;
- (void)cbTouchUpInside;
- (void)cbTouchUpOutside;
- (void)cbTouchCancel;
- (void)cbValueChanged;

@end

@interface N2View : UIView

@end

@interface N2Window : UIWindow

@end

N2UI_BEGIN

#pragma mark view

View::View()
{
    N2View* o = [[N2View alloc] initWithFrame:CGRectZero];
    bindMeta(o);
    OBJC_RELEASE(o);
}

View::View(metapointer_t o)
{
    bindMeta(o);
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
    rc -= edge;
    return rc;
}

#pragma mark window

Window::Window()
: View(nil)
{
    N2Window* o = [[N2Window alloc] initWithFrame:kUIScreenBounds];
    bindMeta(o);
    OBJC_RELEASE(o);
}

Window::Window(metapointer_t o)
: View(o)
{
    
}

Window::~Window()
{
    
}

#pragma mark control

Control::Control()
: View(nil)
{
    
}

Control::~Control()
{
    
}

void Control::bindMeta(metapointer_t o)
{
    View::bindMeta(o);
    
    [o addTarget:o action:@selector(cbTouchCancel) forControlEvents:UIControlEventTouchCancel];
    [o addTarget:o action:@selector(cbTouchDown) forControlEvents:UIControlEventTouchDown];
    [o addTarget:o action:@selector(cbTouchDownRepeat) forControlEvents:UIControlEventTouchDownRepeat];
    [o addTarget:o action:@selector(cbTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [o addTarget:o action:@selector(cbTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [o addTarget:o action:@selector(cbValueChanged) forControlEvents:UIControlEventValueChanged];
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

void Control::onTouchDown(bool repeat)
{
    if (repeat)
    {
        signals().emit(kSignalDbClicked);
    }
    else
    {
        PASS;
    }
}

void Control::onTouchUp(bool inside)
{
    if (inside)
    {
        signals().emit(kSignalClicked);
    }
    else
    {
        PASS;
    }
}

void Control::onTouchCancel()
{
    PASS;
}

N2UI_END

@implementation UIView (n2ext)

- (void)SWIZZLE_CALLBACK(layout_subviews) {
    N2UI_USE;
    View* v = MetaObject::GetObject<View>(self);
    if (v)
        v->onLayout(v->boundsForLayout());
}

@end

@implementation N2View

- (id)init {
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end

@implementation N2Window

@end

@implementation UIControl (n2ext)

- (void)cbTouchDown {
    N2UI_USE;
    Control* ctl = MetaObject::GetObject<Control>(self);
    ptrcall(ctl, onTouchDown(false));
    ptrcall(ctl, signals().emit(kSignalTouchDown));
}

- (void)cbTouchDownRepeat {
    N2UI_USE;
    Control* ctl = MetaObject::GetObject<Control>(self);
    ptrcall(ctl, onTouchDown(true));
    ptrcall(ctl, signals().emit(kSignalTouchDownRepeat));
}

- (void)cbTouchUpInside {
    N2UI_USE;
    Control* ctl = MetaObject::GetObject<Control>(self);
    ptrcall(ctl, onTouchUp(true));
    ptrcall(ctl, signals().emit(kSignalTouchUpInside));
}

- (void)cbTouchUpOutside {
    N2UI_USE;
    Control* ctl = MetaObject::GetObject<Control>(self);
    ptrcall(ctl, onTouchUp(false));
    ptrcall(ctl, signals().emit(kSignalTouchUpOutside));
}

- (void)cbTouchCancel {
    N2UI_USE;
    Control* ctl = MetaObject::GetObject<Control>(self);
    ptrcall(ctl, onTouchCancel());
    ptrcall(ctl, signals().emit(kSignalTouchCancel));
}

- (void)cbValueChanged {
    N2UI_USE;
    Control* ctl = MetaObject::GetObject<Control>(self);
    ptrcall(ctl, signals().emit(kSignalValueChanged));
}

@end
