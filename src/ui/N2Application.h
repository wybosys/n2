
#ifndef __N2APPLICATION_5395AC8F4925465EA04A56EBC27875A7_H_INCLUDED
#define __N2APPLICATION_5395AC8F4925465EA04A56EBC27875A7_H_INCLUDED

N2UI_BEGIN

class Application
: public Object
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
    virtual bool load();
    
};

N2UI_END

#endif