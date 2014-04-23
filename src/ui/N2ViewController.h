
#ifndef __N2VIEWCONTROLLER_359564002B6442DEABFDBE015D7E05AF_H_INCLUDED
#define __N2VIEWCONTROLLER_359564002B6442DEABFDBE015D7E05AF_H_INCLUDED

N2UI_BEGIN

SIGNAL(kSignalViewAppearing) "::ui::view::appearing";
SIGNAL(kSignalViewAppear) "::ui::view::appear";
SIGNAL(kSignalViewDisappearing) "::ui::view::disappearing";
SIGNAL(kSignalViewDisappear) "::ui::view::disappear";

SIGNAL(kSignalTitleChanged) "::ui::title::changed";

class ViewController
: public SObject
{
public:
    
    ViewController();
    ViewController(metapointer_t);
    virtual ~ViewController();
    
    virtual View& view();
    
    virtual void title(String const&);
    virtual String title() const;
    
hybird:
    
    virtual void loadView();
    virtual void onLoaded();
    
    RefPtr<View> _view;
    
    SIGNALS(SObject,
            kSignalViewAppearing, kSignalViewAppear, kSignalViewDisappearing, kSignalViewDisappear,            
            kSignalTitleChanged);
};

template <typename TView>
class Controller
: public ViewController
{
public:
    
    virtual void loadView();
    
    inline TView& view() {
        return (TView&)ViewController::view();
    }
    
};

template <typename TView>
inline void Controller<TView>::loadView()
{
    _view = RefInstance<TView>();
}

N2UI_END

#endif
