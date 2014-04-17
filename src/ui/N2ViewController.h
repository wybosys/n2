
#ifndef __N2VIEWCONTROLLER_359564002B6442DEABFDBE015D7E05AF_H_INCLUDED
#define __N2VIEWCONTROLLER_359564002B6442DEABFDBE015D7E05AF_H_INCLUDED

#import "N2View.h"

N2UI_BEGIN

class ViewController
: public SObject
{
public:
    
    ViewController();
    ViewController(metapointer_t);
    virtual ~ViewController();
    
    virtual View& view();
    
hybird:
    
    virtual void loadView();
    virtual void onLoaded();
    
    RefPtr<View> _view;
};

template <typename TView>
class Controller
: public ViewController
{
public:
    
    virtual void loadView();
    
};

template <typename TView>
inline void Controller<TView>::loadView()
{
    _view = RefInstance<TView>();
}

N2UI_END

#endif
