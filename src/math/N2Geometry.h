
#ifndef __N2GEOMETRY_A961CCE6B5EB4B1A8D33A64DF3B63755_H_INCLUDED
#define __N2GEOMETRY_A961CCE6B5EB4B1A8D33A64DF3B63755_H_INCLUDED

N2MATH_BEGIN

template <typename T>
class Edge
{
public:
    
    Edge(T _t = 0, T _b = 0, T _l = 0, T _r = 0)
    : t(_t), b(_b), l(_l), r(_r)
    {
        
    }
    
    typedef T component_type;
    component_type t, b, l, r;
    
    inline T w() const {
        return l + r;
    }
    
    inline T h() const {
        return t + b;
    }
};

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
    
    inline Rect& operator -= (Edge<T> const& e) {
        origin.x += e.l;
        origin.y += e.t;
        size.w -= e.w();
        size.h -= e.h();
        return *this;
    }
    
    point_type origin;
    size_type size;
    
};

N2MATH_END

#endif
