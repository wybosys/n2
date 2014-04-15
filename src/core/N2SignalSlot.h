
# ifndef __N2SIGNALSLOT_13FE2730AD574827A3615D30CFFCABD6_H_INCLUDED
# define __N2SIGNALSLOT_13FE2730AD574827A3615D30CFFCABD6_H_INCLUDED

# include <string>
# include "N2Values.h"

N2CORE_BEGIN

typedef ::std::string Signal;
class Object;
class Slots;
class Signals;

class Slot
{
public:
    
    Slot();
    ~Slot();
    
    // emit 次数上线，当 count == 0 时会被断开与 signal 的连接，默认为不限制 -1
    uint count;
    
    // 重新定向到的 signal
    // 当本 slot 激活时，将会重定向激活 target 上的该信号
    Signal redirect;
    
    // 传递的数据
    RefPtr<Value> value;
    
    // 执行这个slot
    void emit();
    
protected:
    
    // 源slot
    Ptr<Slot> origin;
    
    // 回调、重定向等依赖的目标对象
    Ptr<Object> target;
    
    // 发送者
    Ptr<Object> sender;
    
};

class Slots
{
public:
    
    Slots();
    
protected:
    
# ifdef DEBUG_MODE
    Signal signal;
    Ptr<Signals> source;
# endif
    
};

class Signals
{
public:
    
    Signals();
    
};

N2CORE_END

# endif
