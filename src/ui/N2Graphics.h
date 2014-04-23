
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
    
#ifdef N2_OBJC
    Size(CGSize const&);
    operator CGSize () const;
#endif
    
    Size integral() const;
    Size bbx() const;
    
};

class Rect
: public math::Rect<real, Point, Size>,
public ZeroObject<Rect>
{
public:
    
    Rect() {}
    
#ifdef N2_OBJC
    Rect(CGRect const&);
    operator CGRect () const;
#endif
    
    Rect integral() const;
    Rect bbx() const;
    
};

N2UI_END

#endif
