
#ifndef __N2NAVIGATION_88B28450C0DD4CF18C7E50A083F6DF79_H_INCLUDED
#define __N2NAVIGATION_88B28450C0DD4CF18C7E50A083F6DF79_H_INCLUDED

N2UI_BEGIN

class Navigation;

class NavigationBar
: public View
{
public:
    
    virtual void hide(bool = true);
    virtual void hide(bool b, bool ani);
 
protected:
    
    NavigationBar();
    virtual ~NavigationBar();
    friend class Navigation;

    Ptr<Navigation> navigation;
    
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
    
protected:
    
    friend class NavigationBar;
};

N2UI_END

# endif
