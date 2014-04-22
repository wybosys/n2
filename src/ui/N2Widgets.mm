
#import "N2Ui.h"
#import "N2Widgets.h"
#import "core/N2Objc.h"

@interface N2Label : UILabel

@end

@interface N2Button : UIButton

@end

N2UI_BEGIN

Label::Label()
{
    N2Label* lbl = [[N2Label alloc] initWithFrame:CGRectZero];
    bindMeta(lbl);
    OBJC_RELEASE(lbl);
}

Label::~Label()
{
    
}

Button::Button()
{
    N2Button* btn = [N2Button buttonWithType:TRIEXPRESS(kIOS7Above, UIButtonTypeSystem, UIButtonTypeCustom)];
    bindMeta(btn);
}

Button::~Button()
{
    
}

void Button::title(String const& str, State sta)
{
    [meta<UIButton>() setTitle:str forState:sta];
}

String Button::title(State sta) const
{
    return [meta<UIButton>() titleForState:sta];
}

void Button::text(Color const& c, State sta)
{
    [meta<UIButton>() setTitleColor:c forState:sta];
}

Color Button::textColor(State sta) const
{
    return [meta<UIButton>() titleColorForState:sta];
}

N2UI_END

@implementation N2Label

@end

@implementation N2Button

@end
