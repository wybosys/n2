
#ifndef __N2GEOMETRY_A961CCE6B5EB4B1A8D33A64DF3B63755_H_INCLUDED
#define __N2GEOMETRY_A961CCE6B5EB4B1A8D33A64DF3B63755_H_INCLUDED

N2MATH_BEGIN

template <typename T>
class Point
{
public:
    
    Point()
    : x(0), y(0)
    {}
    
    typedef T component_type;
    component_type x, y;
};

template <typename T>
class Size
{
public:
    
    Size()
    : w(0), h(0)
    {}
    
    typedef T component_type;
    component_type w, h;
};

template <typename T, typename P = Point<T>, typename S = Size<T> >
class Rect
{
public:
    
    typedef T component_type;
    typedef P point_type;
    typedef S size_type;
    
    point_type origin;
    size_type size;
    
};

N2MATH_END

#endif
