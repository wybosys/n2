
#import "N2Ui.h"
#import "N2Graphics.h"

N2UI_BEGIN

Color::Color()
: argb(0)
{
    
}

Color::Color(Color const& r)
: argb(r.argb)
{
    
}

Color::Color(UIColor* r)
{
    CGFloat const* cmps = CGColorGetComponents(r.CGColor);
    argb = ARGBCode(cmps[0], cmps[1], cmps[2], cmps[3]);
}

Color::Color(byte r, byte g, byte b, byte a)
{
    argb = ARGBCode(r, g, b, a);
}

Color::Color(real r, real g, real b, real a)
{
    argb = ARGBCode(r, g, b, a);
}

Color Color::RGB(int v)
{
    Color ret;
    ret.argb = 0xff000000 | (v & 0xffffff);
    return ret;
}

Color Color::ARGB(int v)
{
    Color ret;
    ret.argb = v;
    return ret;
}

Color Color::RGBA(int v)
{
    Color ret;
    ret.argb = ((v & 0xff) << 24) | ((v & 0xffffff00) >> 8);
    return ret;
}

Color Color::Grayscale(float v)
{
    return Color(1 - v, 1 - v, 1 - v);
}

real Color::Component(ubyte v)
{
    return v / 255.f;
}

byte Color::Component(real v)
{
    return (byte)(255.f * v);
}

float Color::redf() const
{
    return ((argb & 0xff0000) >> 16) / 255.f;
}

float Color::greenf() const
{
    return ((argb & 0xff00) >> 8) / 255.f;
}

float Color::bluef() const
{
    return (argb & 0xff) / 255.f;
}

float Color::alphaf() const
{
    return ((argb & 0xff000000) >> 24) / 255.f;
}

metapointer_t Color::meta() const
{
    return [UIColor colorWithRed:redf() green:greenf() blue:bluef() alpha:alphaf()];
}

int Color::ARGBCode(real r, real g, real b, real a)
{
    return ARGBCode(Component(r), Component(g), Component(b), Component(a));
}

int Color::ARGBCode(byte r, byte g, byte b, byte a)
{
    return (a << 24) | (r << 16) | (g << 8) | b;
}

const Color Color::White = Color::ARGB(0xffffffff);
const Color Color::Black = Color::ARGB(0xff000000);
const Color Color::Red = Color::ARGB(0xffff0000);
const Color Color::Green = Color::ARGB(0xff00ff00);
const Color Color::Blue = Color::ARGB(0xff0000ff);
const Color Color::Gray = Color::Grayscale(.3f);

Point::Point(CGPoint const& pt)
{
    x = pt.x;
    y = pt.y;
}

Point::operator CGPoint () const
{
    return CGPointMake(x, y);
}

Point Point::integral() const
{
    Point r;
    r.x = floor(x);
    r.y = floor(y);
    return r;
}

Point Point::bbx() const
{
    Point r;
    r.x = ceil(x);
    r.y = ceil(y);
    return r;
}

Size::Size(CGSize const& sz)
{
    w = sz.width;
    h = sz.height;
}

Size::operator CGSize () const
{
    return CGSizeMake(w, h);
}

Size Size::integral() const
{
    Size r;
    r.w = floor(w);
    r.h = floor(h);
    return r;
}

Size Size::bbx() const
{
    Size r;
    r.w = ceil(w);
    r.h = ceil(h);
    return r;
}

Rect::Rect(CGRect const& r)
{
    origin = r.origin;
    size = r.size;
}

Rect::operator CGRect () const
{
    return CGRectMake(origin.x, origin.y, size.w, size.h);
}

Rect Rect::integral() const
{
    Rect r;
    r.origin = origin.integral();
    r.size = size.integral();
    return r;
}

Rect Rect::bbx() const
{
    Rect r;
    r.origin = origin.bbx();
    r.size = size.bbx();
    return r;
}

N2UI_END
