
#ifndef __N2APPLICATION_5395AC8F4925465EA04A56EBC27875A7_H_INCLUDED
#define __N2APPLICATION_5395AC8F4925465EA04A56EBC27875A7_H_INCLUDED

N2UI_BEGIN

SIGNAL(kSignalApplicationActived) "::sys::app::actived";
SIGNAL(kSignalApplicationActiving) "::sys::app::activiting";
SIGNAL(kSignalApplicationDeactived) "::sys::app::deactived";
SIGNAL(kSignalApplicationDeactiving) "::sys::app::deactiving";

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
    
    // 启动，顺序 bootstrap->load
    virtual bool bootstrap();
    virtual void load();
    
    SIGNALS(SObject,
            kSignalApplicationActived,
            kSignalApplicationActiving,
            kSignalApplicationDeactived,
            kSignalApplicationDeactiving
            );
    
};

N2UI_END

#endif