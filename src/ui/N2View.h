
# ifndef __N2VIEW_FDD406DA58574B31B98B1199757A2C99_H_INCLUDED
# define __N2VIEW_FDD406DA58574B31B98B1199757A2C99_H_INCLUDED

N2UI_BEGIN

class View
: public SObject
{
public:
    
    View();
    virtual ~View();
    
    virtual void hidden(bool);
    virtual bool ishidden() const;
    void visible(bool);
    bool isvisible() const;
    
};

N2UI_END

# endif
