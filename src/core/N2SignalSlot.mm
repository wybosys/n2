
# include "N2Core.h"
# include "N2SignalSlot.h"
# include <stdarg.h>

N2_BEGIN

Slot::Slot()
: count(-1)
{
    
}

Slot::~Slot()
{
    
}

void Slot::emit()
{
    if (!redirect.empty() && !target.isnull())
    {
        target->signals().emit(redirect, data);
    }
    
    if (func_s != nullptr)
    {
        (*func_s)(*this);
    }
    
    if (func_sl != nullptr)
    {
        (*func_sl)();
    }
    
    if (*func_λ != nullptr)
    {
        (*func_λ)(*this);
    }
    
    if (*func_λl != nullptr)
    {
        (*func_λl)();
    }
    
    if (func_m != nullptr && !target.isnull())
    {
        (target->*func_m)(*this);
    }
}

void Slot::copy(Slot const& r)
{
    count = r.count;
    redirect = r.redirect;
    data = mutable_cast(r).data;
    func_s = r.func_s;
    func_sl = r.func_sl;
    func_λ = r.func_λ;
    func_λl = r.func_λl;
    func_m = r.func_m;
    
    source = r.source;
    target = r.target;
    sender = r.sender;
}

Slots::Slots()
{
    
}

Slots::~Slots()
{
    for (auto i = _slots.begin(); i != _slots.end(); ++i)
        obj_release(*i);
}

void Slots::copy(Slots const& r)
{
# ifdef DEBUG_MODE
    signal = r.signal;
    source = r.source;
# endif
    
    // 清空原来的
    for (auto i = _slots.begin(); i != _slots.end(); ++i)
        obj_release(*i);
    _slots.clear();
    
    // 复制新的
    for (auto i = r._slots.begin(); i != r._slots.end(); ++i)
    {
        Slot* r = new Slot();
        r->copy(**i);
        r->source = *i;
        _slots.push_back(r);
    }
}

bool Slots::connect(signal_t const& redirect, SObject* target)
{
    if (find(redirect, target))
        return false;
    Slot* s = new Slot();
    s->redirect = redirect;
    s->target = target;
    _slots.push_back(s);
    return true;
}

bool Slots::connect(Slot::cb_sfunction sfunc)
{
    if (find(sfunc))
        return false;
    Slot* s = new Slot();
    s->func_s = sfunc;
    _slots.push_back(s);
    return true;
}

bool Slots::connect(Slot::cb_slfunction slfunc)
{
    if (find(slfunc))
        return false;
    Slot* s = new Slot();
    s->func_sl = slfunc;
    _slots.push_back(s);
    return true;
}

bool Slots::connect(Slot::cb_λfunction λfunc)
{
    Slot::cb_sfunction* sfunc = λfunc.target<Slot::cb_sfunction>();
    // 普通静态函数
    if (sfunc != nullptr)
        return connect(*sfunc);
    
    // lambda
    Slot* s = new Slot();
    s->func_λ = λfunc;
    _slots.push_back(s);
    return true;
}

bool Slots::connect(Slot::cb_λlfunction λlfunc)
{
    Slot::cb_slfunction* slfunc = λlfunc.target<Slot::cb_slfunction>();
    // 普通静态函数
    if (slfunc != nullptr)
        return connect(*slfunc);
    
    // lambda
    Slot* s = new Slot();
    s->func_λl = λlfunc;
    _slots.push_back(s);
    return true;
}

bool Slots::connect(Slot::cb_mfunction mfunc, SObject* target)
{
    if (find(mfunc, target))
        return false;
    Slot* s = new Slot();
    s->func_m = mfunc;
    s->target = target;
    _slots.push_back(s);
    return true;
}

Slot* Slots::find(signal_t const& redirect, SObject* target) const
{
    for (auto i = _slots.begin(); i != _slots.end(); ++i)
    {
        Slot* s = *i;
        if (s->redirect == redirect &&
            s->target == target)
            return s;
    }
    return nullptr;
}

Slot* Slots::find(Slot::cb_sfunction sfunc) const
{
    for (auto i = _slots.begin(); i != _slots.end(); ++i)
    {
        Slot* s = *i;
        if (s->func_s == sfunc)
            return s;
    }
    return nullptr;
}

Slot* Slots::find(Slot::cb_slfunction slfunc) const
{
    for (auto i = _slots.begin(); i != _slots.end(); ++i)
    {
        Slot* s = *i;
        if (s->func_sl == slfunc)
            return s;
    }
    return nullptr;
}

Slot* Slots::find(Slot::cb_mfunction mfunc, SObject* target) const
{
    for (auto i = _slots.begin(); i != _slots.end(); ++i)
    {
        Slot* s = *i;
        if (s->func_m == mfunc &&
            s->target == target)
            return s;
    }
    return nullptr;
}

void Slots::run()
{
    
}

Signals::Signals()
{
    
}

Signals::~Signals()
{
    // 断开所有的反连接
    for (auto i = _reflects.begin(); i != _reflects.end(); ++i)
    {
        Slots* rss = *i;
        auto j = rss->_slots.begin();
        while (j != rss->_slots.end())
        {
            Slot* rs = *j;
            if (rs->target == owner)
            {
                j = rss->_slots.erase(j);
            }
        }
    }
    
    // 清空所有的已连接插槽
    for (auto i = _ss.begin(); i != _ss.end(); ++i)
        obj_release(i->second);
    _ss.clear();
}

Signals& Signals::add(signal_t const& sig)
{
    auto found = _ss.find(sig);
    if (found == _ss.end())
    {
        Slots* ss = new Slots();
        
#ifdef DEBUG_MODE
        ss->signal = sig;
        ss->source = this;
#endif
        
        _ss[sig] = ss;
    }
    return *this;
}

Signals& Signals::add(::std::initializer_list<signal_t> sigs)
{
    for (auto i = sigs.begin(); i != sigs.end(); ++i)
        add(*i);
    return *this;
}

Signals& Signals::emit(signal_t const& s)
{
    return emit(s, Variant::Zero);
}

Signals& Signals::emit(signal_t const& s, Variant const& v)
{
    auto found = _ss.find(s);
    if (found == _ss.end())
    {
        WARN("没有找到该信号 %s", s.c_str());
        return *this;
    }
    
    Slots* ss = found->second;
    
    // 运行一下，裁剪不可用的插槽
    ss->run();
    
    // 如果是空的，则不运行
    if (ss->_slots.size() == 0)
        return *this;
    
    // 复制出用于激活的插槽集合
    Instance<Slots> tmpss;
    tmpss->copy(*ss);
    
    // 激活所有的slot
    for (auto i = tmpss->_slots.begin(); i != tmpss->_slots.end(); ++i)
    {
        Slot* s = *i;
        
        // 绑定运行数据
        s->sender = owner;
        s->data = v;
        
        // 运行
        s->emit();
    }
    
    return *this;
}

void Signals::connect(signal_t const& sig, signal_t const& redirect, SObject* target)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(redirect, target);
    target->signals()._reflects.insert(fnds->second);
}

/*
void Signals::connect(signal_t const& sig, Slot::cb_sfunction sfunc)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(sfunc);
}
 */

void Signals::connect(signal_t const& sig, Slot::cb_λfunction λfunc)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(λfunc);
}

void Signals::connect(signal_t const& sig, Slot::cb_λlfunction λlfunc)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(λlfunc);
}

void Signals::connect(signal_t const& sig, Slot::cb_mfunction mfunc, SObject* target)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(mfunc, target);
    target->signals()._reflects.insert(fnds->second);
}

SObject::SObject()
{
    
}

SObject::~SObject()
{
    
}

Signals& SObject::signals() const
{
    return getSignals();
}

Signals& SObject::getSignals() const
{
    lock();
    if (sigs.isnull())
    {
        sigs = new Signals();
        sigs->owner = mutable_cast(this);
        mutable_cast(this)->init_signals();
    }
    unlock();
    return sigs;
}

void SObject::init_signals()
{
    PASS;
}

N2_END
