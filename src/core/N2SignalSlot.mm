
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
        SObject* so = dynamic_cast<SObject*>((Object*)target);
        if (so)
            so->signals().emit(redirect, data);
    }
    
    if (func_s != nullptr)
    {
        (*func_s)(*this);
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
    
    _slots.clear();
    for (auto i = r._slots.begin(); i != r._slots.end(); ++i)
    {
        Slot* r = new Slot();
        r->copy(**i);
        r->source = *i;
        _slots.push_back(r);
    }
}

bool Slots::connect(signal_t const& redirect, Object* target)
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

bool Slots::connect(Slot::cb_mfunction mfunc, Object* target)
{
    if (find(mfunc, target))
        return false;
    Slot* s = new Slot();
    s->func_m = mfunc;
    s->target = target;
    _slots.push_back(s);
    return true;
}

Slot* Slots::find(signal_t const& redirect, Object* target) const
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

Slot* Slots::find(Slot::cb_mfunction mfunc, Object* target) const
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
    for (auto i = _ss.begin(); i != _ss.end(); ++i)
        obj_release(i->second);
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

void Signals::connect(signal_t const& sig, signal_t const& redirect, Object* target)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(redirect, target);
}

void Signals::connect(signal_t const& sig, Slot::cb_sfunction sfunc)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(sfunc);
}

void Signals::connect(signal_t const& sig, Slot::cb_mfunction mfunc, Object* target)
{
    auto fnds = _ss.find(sig);
    if (fnds == _ss.end())
        return;
    fnds->second->connect(mfunc, target);
}

SObject::SObject()
{
    
}

SObject::~SObject()
{
    
}

Signals& SObject::signals() const
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
