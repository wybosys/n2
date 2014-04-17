
#import "N2Ui.h"
#import "N2Graphics.h"

N2UI_BEGIN

Color::Color()
{
    
}

Color::Color(Color const& r)
: rgba(r.rgba)
{
    
}

Color::Color(UIColor* r)
{
    setMeta(r);
}

Color Color::RGB(int v)
{
    Color ret;
    ret.rgba = 0xff000000 | (v & 0xffffff);
    return ret;
}

Color Color::ARGB(int v)
{
    Color ret;
    ret.rgba = ((v & 0xffffff) << 8) | ((v & 0xff000000) >> 24);
    return ret;
}

Color Color::RGBA(int v)
{
    Color ret;
    ret.rgba = v;
    return ret;
}

float Color::redf() const
{
    return ((rgba & 0xff000000) >> 24) / 255.f;
}

float Color::greenf() const
{
    return ((rgba & 0xff0000) >> 16) / 255.f;
}

float Color::bluef() const
{
    return ((rgba & 0xff00) >> 8) / 255.f;
}

float Color::alphaf() const
{
    return (rgba & 0xff) / 255.f;
}

metapointer_t Color::getMeta() const
{
    return [UIColor colorWithRed:redf() green:greenf() blue:bluef() alpha:alphaf()];
}

const Color Color::White = Color::ARGB(0xffffffff);
const Color Color::Black = Color::ARGB(0xff000000);

N2UI_END
