
#ifndef __N2GRAPHICS_40FB029CAF4C48529854CC332914F1FC_H_INCLUDED
#define __N2GRAPHICS_40FB029CAF4C48529854CC332914F1FC_H_INCLUDED

#include "math/N2Math.h"
#include "math/N2Geometry.h"

N2UI_BEGIN

class Color
: public Object
{
public:
    
    Color();
    Color(Color const&);
    Color(byte r, byte g, byte b, byte a = 255);
    Color(real r, real g, real b, real a = 1.f);
    
#ifdef N2_OBJC
    Color(UIColor*);
#endif
    
    static Color RGBA(int);
    static Color ARGB(int);
    static Color RGB(int);
    static Color Grayscale(float);
    
    float redf() const;
    float greenf() const;
    float bluef() const;
    float alphaf() const;
    
    int argb;
    
    static const Color White, Black, Red, Green, Blue, Gray;
    
    static real Component(ubyte);
    static byte Component(real);
    static int ARGBCode(real r, real g, real b, real a);
    static int ARGBCode(byte r, byte g, byte b, byte a);
    
protected:
    
    metapointer_t _meta() const;
    
};

class Rect;
class Size;
class Point;

class Edge
: public math::Edge<real>,
public ZeroObject<Rect>
{
public:
};

class Point
: public math::Point<real>,
public ZeroObject<Rect>
{
public:
    
    Point() {}
    Point(Size const&);
    
#ifdef N2_OBJC
    Point(CGPoint const&);
    operator CGPoint () const;
#endif
    
    Point integral() const;
    Point bbx() const;
    
};

class Size
: public math::Size<real>,
public ZeroObject<Rect>
{
public:
    
    Size() {}
    Size(Point const&);
    
#ifdef N2_OBJC
    Size(CGSize const&);
    operator CGSize () const;
#endif
    
    Size integral() const;
    Size bbx() const;
    
};

inline Point::Point(Size const& sz)
{
    x = sz.w;
    y = sz.h;
}

inline Size::Size(Point const& pt)
{
    w = pt.x;
    h = pt.y;
}

class Rect
: public math::Rect<real, Point, Size>,
public ZeroObject<Rect>
{
public:
    
    Rect() {}
    Rect(Size const& sz) {
        size = sz;
    }
    Rect(Point const& pt) {
        origin = pt;
    }
    Rect(Point const& pt, Size const& sz) {
        origin = pt;
        size = sz;
    }
    
#ifdef N2_OBJC
    Rect(CGRect const&);
    operator CGRect () const;
#endif
    
    Rect integral() const;
    Rect bbx() const;
    
};

class Image
: public Object
{
public:
    
    Image();
    Image(Image const&);
    virtual ~Image();
    
#ifdef N2_OBJC
    Image(UIImage*);
    operator CGImageRef () const;
#endif
    
    Size size() const;
    
};

N2UI_END

#endif
