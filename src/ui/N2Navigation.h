
#ifndef __N2NAVIGATION_88B28450C0DD4CF18C7E50A083F6DF79_H_INCLUDED
#define __N2NAVIGATION_88B28450C0DD4CF18C7E50A083F6DF79_H_INCLUDED

N2UI_BEGIN

class Navigation;

class NavigationBar
: public View
{
    NavigationBar();
    friend class Navigation;

public:
    
};

class Navigation
: public ViewController
{
public:
    
    Navigation();
    virtual ~Navigation();
  
    NavigationBar bar;
    
    void push(ViewController&, bool = animation);
    void pop(bool = animation);
    
};

N2UI_END

# endif
