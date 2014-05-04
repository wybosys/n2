
# ifndef __N2SIGNALSLOT_13FE2730AD574827A3615D30CFFCABD6_H_INCLUDED
# define __N2SIGNALSLOT_13FE2730AD574827A3615D30CFFCABD6_H_INCLUDED

# include "N2Values.h"

N2_BEGIN

typedef ::std::string signal_t;
class Slots;
class Signals;
class SObject;

class Slot
: public Copyable<Slot>,
public ReferenceObject
{
public:
    
    Slot();
    ~Slot();
    
    // emit 次数上线，当 count == 0 时会被断开与 signal 的连接，默认为不限制 -1
    uint count;
    
    // 重新定向到的 signal
    // 当本 slot 激活时，将会重定向激活 target 上的该信号
    signal_t redirect;
    
    // 传递的数据
    Variant data;
    
    // 全局函数插槽
    typedef void (*cb_sfunction)(Slot&);
    typedef void (*cb_slfunction)();
    Value<cb_sfunction> func_s;
    Value<cb_slfunction> func_sl;
    typedef ::std::function<void(Slot&)> cb_λfunction;
    typedef ::std::function<void()> cb_λlfunction;
    Value<cb_λfunction> func_λ;
    Value<cb_λlfunction> func_λl;
    
    // 成员函数插槽
    typedef void (Object::*cb_mfunction)(Slot&);
    Value<cb_mfunction> func_m;
    
    // 背景运行
    bool background;
    
    // 执行这个slot
    void emit();
    
    // 源slot
    Ptr<Slot> source;
    
    // 回调、重定向等依赖的目标对象
    Ptr<SObject> target;
    
    // 发送者
    Ptr<SObject> sender;
    
    void copy(Slot const&);
    
protected:
    
    void _emit_prepare();
    void _emit();
    void _emit_collect();
    
    friend void SlotDoAsyncEmit(Slot*);
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
    signal_t signal;
    Ptr<Signals> source;
# endif
    
    // slots的绑定方法
    // true 绑定成功
    // false 绑定失败或已经绑定
    bool connect(signal_t const& redirect, SObject*);
    bool connect(Slot::cb_sfunction);
    bool connect(Slot::cb_slfunction);
    bool connect(Slot::cb_λfunction);
    bool connect(Slot::cb_λlfunction);
    bool connect(Slot::cb_mfunction, SObject*);
    
    // 根据条件查找slot
    Slot* find(signal_t const& redirect, SObject*) const;
    Slot* find(Slot::cb_sfunction) const;
    Slot* find(Slot::cb_slfunction) const;
    Slot* find(Slot::cb_mfunction, SObject*) const;
    
    // 运行一遍
    void run();
    
    friend class Signals;
    
private:
    
    ::std::vector<Slot*> _slots;
};

class Signals
{
public:
    
    Signals();
    ~Signals();
    
    // 所有者
    Ptr<SObject> owner;
  
    // 注册信号
    Signals& add(signal_t const&);
    Signals& add(::std::initializer_list<signal_t>);
    
    // 激活信号
    Signals& emit(signal_t const&);
    Signals& emit(signal_t const&, Variant const&);
    
    // 绑定
    void connect(signal_t const&, signal_t const& redirect, SObject*);
    void connect(signal_t const&, SObject*);
    //void connect(signal_t const&, Slot::cb_sfunction);
    void connect(signal_t const&, Slot::cb_λfunction);
    void connect(signal_t const&, Slot::cb_λlfunction);
    void connect(signal_t const&, Slot::cb_mfunction, SObject*);
    
private:
    
    ::std::map<signal_t, Slots*> _ss;
    ::std::set<Slots*> _reflects;
};

class SObject
: public Object
{
public:
    
    SObject();
    virtual ~SObject();
    
    Signals& signals() const;
    
protected:
    
    virtual void _initSignals();
    Signals& _getSignals() const;
    
    mutable LazyInstance<Signals> sigs;
};

#define SIGNAL(sig) static const ::N2NS::signal_t sig = 
#define SIGNALS(super, ...) protected: virtual void _initSignals() { super::_initSignals(); sigs->add({__VA_ARGS__}); }
#define slot(s) ((::N2NS::Slot::cb_mfunction)&s)

SIGNAL(kSignalSucceed) "::any::done";
SIGNAL(kSignalFailed) "::any::failed";
SIGNAL(kSignalCancel) "::any::cancel";
SIGNAL(kSignalDoing) "::any::doing";
SIGNAL(kSignalStart) "::any::doing";
SIGNAL(kSignalDone) "::any::done";
SIGNAL(kSignalAction) "::any::action";
SIGNAL(kSignalProcessed) "::any::processed";
SIGNAL(kSignalNext) "::any::next";
SIGNAL(kSignalPrevious) "::any::previous";
SIGNAL(kSignalAdded) "::any::added";
SIGNAL(kSignalRemvoed) "::any::removed";
SIGNAL(kSignalSelectionChanging) "::any::selection::changing";
SIGNAL(kSignalSelectionChanged) "::any::selection::changed";
SIGNAL(kSignalValueChanging) "::any::value::changing";
SIGNAL(kSignalValueChanged) "::any::value::changed";

N2_END

# endif
