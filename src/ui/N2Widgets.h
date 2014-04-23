
#ifndef __N2WIDGETS_139497AED1984B18B14D7C8DEA366C6D_H_INCLUDED
#define __N2WIDGETS_139497AED1984B18B14D7C8DEA366C6D_H_INCLUDED

N2UI_BEGIN

class Label
: public View
{
public:
    
    Label();
    virtual ~Label();
    
    virtual void text(String const&);
    virtual String text() const;
    
};

class Button
: public Control
{
public:
    
    Button();
    virtual ~Button();
    
    virtual void text(String const&, State = Normal);
    virtual String text(State = Normal) const;
    
    virtual void text(Color const&, State = Normal);
    virtual Color textColor(State = Normal) const;
    
};

class TextField
: public Control
{
public:
    
    TextField();
    virtual ~TextField();
    
};

class Picture
: public View
{
public:
    
    Picture();
    virtual ~Picture();
    
};

class Scroll
: public View
{
public:
    
    Scroll();
    virtual ~Scroll();
    
protected:
    
    Scroll(metapointer_t);
    
};

class TextArea
: public Scroll
{
public:
    
    TextArea();
    virtual ~TextArea();
    
};

class Keyboard
: public SObject,
public Singleton<Keyboard>
{
public:
    
    // 关闭当前键盘
    static void Close();
    
protected:
    
    Keyboard();
    
    friend class Singleton<Keyboard>;
};

N2UI_END

#endif
