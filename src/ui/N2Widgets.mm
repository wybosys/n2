
#import "N2Ui.h"
#import "N2Widgets.h"
#import "core/N2Objc.h"

@interface N2Label : UILabel

@end

@interface N2Button : UIButton

@end

@interface N2TextField : UITextField

@end

@interface N2ImageView : UIImageView

@end

@interface N2ScrollView: UIScrollView

@end

@interface N2TextView : UITextView

@end

N2UI_BEGIN

#pragma mark label

Label::Label()
{
    N2Label* lbl = [[N2Label alloc] initWithFrame:CGRectZero];
    bindMeta(lbl);
    OBJC_RELEASE(lbl);
}

Label::~Label()
{
    
}

void Label::text(String const& str)
{
    [meta() setText:str];
}

String Label::text() const
{
    return [meta() text];
}

#pragma mark button

Button::Button()
{
    N2Button* btn = [N2Button buttonWithType:TRIEXPRESS(kIOS7Above, UIButtonTypeSystem, UIButtonTypeCustom)];
    bindMeta(btn);
}

Button::~Button()
{
    
}

void Button::text(String const& str, State sta)
{
    [meta<UIButton>() setTitle:str forState:sta];
}

String Button::text(State sta) const
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

#pragma mark textfield

TextField::TextField()
{
    N2TextField* tx = [[N2TextField alloc] initWithFrame:CGRectZero];
    bindMeta(tx);
    OBJC_RELEASE(tx);
}

TextField::~TextField()
{
    
}

#pragma mark picture

Picture::Picture()
{
    N2ImageView* img = [[N2ImageView alloc] initWithFrame:CGRectZero];
    bindMeta(img);
    OBJC_RELEASE(img);
}

Picture::~Picture()
{
    
}

#pragma mark scroll

Scroll::Scroll()
{
    N2ScrollView* sc = [[N2ScrollView alloc] initWithFrame:CGRectZero];
    bindMeta(sc);
    OBJC_RELEASE(sc);
}

Scroll::Scroll(metapointer_t o)
{
    bindMeta(o);
}

Scroll::~Scroll()
{
    
}

#pragma mark texteditor

TextEditor::TextEditor()
: Scroll(nil)
{
    N2TextView* tx = [[N2TextView alloc] initWithFrame:CGRectZero];
    bindMeta(tx);
    OBJC_RELEASE(tx);
}

TextEditor::~TextEditor()
{
    
}

N2UI_END

@implementation N2Label

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end

@implementation N2Button

@end

@implementation N2TextField

@end

@implementation N2ImageView

@end

@implementation N2ScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end

@implementation N2TextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end
