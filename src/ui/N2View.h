
#ifndef __N2VIEW_FDD406DA58574B31B98B1199757A2C99_H_INCLUDED
#define __N2VIEW_FDD406DA58574B31B98B1199757A2C99_H_INCLUDED

#include "N2Graphics.h"
#include "N2Layout.h"

N2UI_BEGIN

SIGNAL(kSignalTouchesBegan) "::ui::touches::began";
SIGNAL(kSignalTouchesEnded) "::ui::touches::ended";
SIGNAL(kSignalTouchesCancel) "::ui::touches::cancel";
SIGNAL(kSignalTouchesMoved) "::ui::touches::moved";
SIGNAL(kSignalTouchesDone) "::ui::touches::done";

static const Const<true> show = Const<true>();
static const Const<false> hide = Const<false>();

class View
: public SObject
{
public:
    
    View();
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
    
hybird:
    
    virtual void onLayout(Rect const&);
    virtual Rect boundsForLayout() const;
    
    SIGNALS(SObject,
            kSignalTouchesBegan, kSignalTouchesCancel, kSignalTouchesDone, kSignalTouchesEnded, kSignalTouchesMoved
            );
};

N2UI_END

# endif
