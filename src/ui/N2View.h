
#ifndef __N2VIEW_FDD406DA58574B31B98B1199757A2C99_H_INCLUDED
#define __N2VIEW_FDD406DA58574B31B98B1199757A2C99_H_INCLUDED

#include "N2Graphics.h"
#include "N2Layout.h"

N2UI_BEGIN

//extern const float kDurationLongTouch;
//extern const float kDurationDbTouchInterval;

SIGNAL(kSignalTouchBegan) "::ui::touch::began";
SIGNAL(kSignalTouchEnded) "::ui::touch::ended";
SIGNAL(kSignalTouchCancel) "::ui::touch::cancel";
SIGNAL(kSignalTouchMoved) "::ui::touch::moved";
SIGNAL(kSignalTouchDone) "::ui::touch::done";

SIGNAL(kSignalClicked) "::ui::clicked";
SIGNAL(kSignalDbClicked) "::ui::dbclicked";
SIGNAL(kSignalLongClicked) "::ui::longclicked";

static const Const<true> show = Const<true>();
static const Const<false> hide = Const<false>();
static const Const<true> on = Const<true>();
static const Const<false> off = Const<false>();

class View
: public SObject
{
public:
    
    View();
    View(metapointer_t);
    virtual ~View();
    
    virtual void hide(bool = true);
    virtual bool ishidden() const;
    void visible(bool = show);
    bool isvisibled() const;
    
    virtual void background(Color const&);
    virtual Color backgroundColor() const;
        
    virtual void frame(Rect const&);
    virtual Rect frame() const;
    virtual Rect bounds() const;
    
    virtual void add(View&);
    
    struct
    {
        Value<int> touched;
        Value<bool> longclicking;
    } extension;
    
    Edge edge;
    
hybrid:
    
    virtual void onLayout(Rect const&);
    virtual Rect boundsForLayout() const;
    
    SIGNALS(SObject,
            kSignalTouchBegan, kSignalTouchCancel, kSignalTouchDone, kSignalTouchEnded, kSignalTouchMoved,
            kSignalClicked, kSignalDbClicked, kSignalLongClicked
            );
};

class Window
: public View
{
public:
    
    Window();
    Window(metapointer_t);
    virtual ~Window();
    
    friend class Application;
};

SIGNAL(kSignalTouchDown) "::ui::touch::down";
SIGNAL(kSignalTouchDownRepeat) "::ui::touch::down::repeat";
SIGNAL(kSignalTouchUpInside) "::ui::touch::up::inside";
SIGNAL(kSignalTouchUpOutside) "::ui::touch::up::outside";

class Control
: public View
{
public:
    
    Control();
    virtual ~Control();
    
    typedef enum {
        Normal = UIControlStateNormal,
        Highlight = UIControlStateHighlighted,
        Disabled = UIControlStateDisabled,
        Selected = UIControlStateSelected,
    } State;
    
    virtual void enable(bool = on);
    virtual bool isenabled() const;
    
    virtual void select(bool = on);
    virtual bool isselected() const;
    
    virtual void highlight(bool = on);
    virtual bool ishighlighted() const;
    
hybrid:
    
    virtual void onTouchDown(bool repeat);
    virtual void onTouchUp(bool inside);
    virtual void onTouchCancel();
    
protected:
    
    void _bindMeta(metapointer_t);

    SIGNALS(View,
            kSignalTouchDown, kSignalTouchDownRepeat, kSignalTouchUpInside, kSignalTouchUpOutside, kSignalTouchCancel,
            kSignalValueChanged, kSignalValueChanging
            );
};

N2UI_END

# endif
