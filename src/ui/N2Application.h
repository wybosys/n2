
#ifndef __N2APPLICATION_5395AC8F4925465EA04A56EBC27875A7_H_INCLUDED
#define __N2APPLICATION_5395AC8F4925465EA04A56EBC27875A7_H_INCLUDED

#include "N2Navigation.h"

N2UI_BEGIN

SIGNAL(kSignalApplicationActived) "::sys::app::actived";
SIGNAL(kSignalApplicationActiving) "::sys::app::activiting";
SIGNAL(kSignalApplicationDeactived) "::sys::app::deactived";
SIGNAL(kSignalApplicationDeactiving) "::sys::app::deactiving";
SIGNAL(kSignalApplicationOrientationChanging) "::sys::app::orientation::changing";
SIGNAL(kSignalApplicationOrientationChanged) "::sys::app::orientation::changed";

class Application
: public SObject
{
    PRIVATE(Application);
    
public:
    
    Application();
    virtual ~Application();

    static Application& shared();
    
    // 启动
    int execute();
    int execute(int, char**);
    
    // 启动，顺序 bootstrap->start->load
    virtual bool bootstrap();
    virtual void start();
    virtual void load();
    
    // 根vc
    RefPtr<Navigation> root;
    
    // 根window
    Window window;
    
hybird:
    
    void bindWindow(metapointer_t);
    
    SIGNALS(SObject,
            kSignalApplicationActived, kSignalApplicationActiving,
            kSignalApplicationDeactived, kSignalApplicationDeactiving,
            kSignalApplicationOrientationChanging, kSignalApplicationOrientationChanged
            );

};

N2UI_END

#endif