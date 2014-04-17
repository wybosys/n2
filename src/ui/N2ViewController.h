
#ifndef __N2VIEWCONTROLLER_359564002B6442DEABFDBE015D7E05AF_H_INCLUDED
#define __N2VIEWCONTROLLER_359564002B6442DEABFDBE015D7E05AF_H_INCLUDED

N2UI_BEGIN

class ViewController
: public SObject
{
public:
    
    ViewController();
    virtual ~ViewController();
    
};

template <typename TView>
class Controller
: public ViewController
{
    
};

N2UI_END

#endif
