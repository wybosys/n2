
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
    
#ifdef N2_OBJC
    Color(UIColor*);
#endif
    
    static Color RGBA(int);
    static Color ARGB(int);
    static Color RGB(int);
    
    float redf() const;
    float greenf() const;
    float bluef() const;
    float alphaf() const;
    
    int rgba;
    
    static const Color White, Black;
    
protected:
    
    metapointer_t getMeta() const;
    
};

class Point
: public math::Point<real>
{
public:
    
    Point() {}
    
#ifdef N2_OBJC
    Point(CGPoint const&);
    operator CGPoint () const;
#endif
    
};

class Size
: public math::Size<real>
{
public:
    
    Size() {}
    
#ifdef N2_OBJC
    Size(CGSize const&);
    operator CGSize () const;
#endif
    
};

class Rect
: public math::Rect<real, Point, Size>
{
public:
    
    Rect() {}
    
#ifdef N2_OBJC
    Rect(CGRect const&);
    operator CGRect () const;
#endif
    
};

N2UI_END

#endif
