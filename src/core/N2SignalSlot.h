
# ifndef __N2SIGNALSLOT_13FE2730AD574827A3615D30CFFCABD6_H_INCLUDED
# define __N2SIGNALSLOT_13FE2730AD574827A3615D30CFFCABD6_H_INCLUDED

# include "N2Values.h"

N2_BEGIN

typedef ::std::string Signal;
class Slots;
class Signals;

class Slot
: public Copyable<Slot>
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
    
    void copy(Slot const&);
    
protected:
    
    // 源slot
    Ptr<Slot> origin;
    
    // 回调、重定向等依赖的目标对象
    Ptr<Object> target;
    
    // 发送者
    Ptr<Object> sender;
    
};

class Slots
: public Copyable<Slots>
{
public:
    
    Slots();
    ~Slots();
    
    void copy(Slots const&);
    
protected:
    
# ifdef DEBUG_MODE
    Signal signal;
    Ptr<Signals> source;
# endif
    
private:
    
    PtrVector<Slot> _slots;
};

class Signals
{
public:
    
    Signals();
    ~Signals();
    
    // 所有者
    Ptr<Object> owner;
  
private:
    
    ::std::set<Slot*> _reflects;
};

class SObject
: public Object
{
public:
    
    SObject();
    virtual ~SObject();
    
    Signals& signals() const;
    
protected:
    
    virtual void init_signals();
    
    mutable Ptr<Signals> sigs;
};

N2_END

# endif
