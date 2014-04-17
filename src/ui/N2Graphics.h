
#ifndef __N2GRAPHICS_40FB029CAF4C48529854CC332914F1FC_H_INCLUDED
#define __N2GRAPHICS_40FB029CAF4C48529854CC332914F1FC_H_INCLUDED

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

N2UI_END

#endif
