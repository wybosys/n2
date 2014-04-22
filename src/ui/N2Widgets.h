
#ifndef __N2WIDGETS_139497AED1984B18B14D7C8DEA366C6D_H_INCLUDED
#define __N2WIDGETS_139497AED1984B18B14D7C8DEA366C6D_H_INCLUDED

N2UI_BEGIN

class Label
: public View
{
public:
    
    Label();
    virtual ~Label();
    
};

class Button
: public Control
{
public:
    
    Button();
    virtual ~Button();
    
    virtual void title(String const&, State = Normal);
    virtual String title(State = Normal) const;
    
    virtual void text(Color const&, State = Normal);
    virtual Color textColor(State = Normal) const;
    
};

N2UI_END

#endif
