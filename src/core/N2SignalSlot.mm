
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
    
}

void Slot::copy(Slot const& r)
{
    count = r.count;
    redirect = r.redirect;
    data = mutable_cast(r).data;
    
    origin = r.origin;
    target = r.target;
    sender = r.sender;
}

Slots::Slots()
{
    
}

Slots::~Slots()
{
    
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
        _slots.push_back(r);
    }
}

void Slots::run()
{
    
}

Signals::Signals()
{
    
}

Signals::~Signals()
{
    
}

Signals& Signals::add(::std::initializer_list<signal_t> sigs)
{
    for (auto i = sigs.begin(); i != sigs.end(); ++i)
    {
        auto found = _ss.find(*i);
        if (found == _ss.end())
        {
            _ss[*i] = new Slots();
        }
    }
    return *this;
}

Signals& Signals::emit(signal_t const& s)
{
    auto found = _ss.find(s);
    if (found == _ss.end())
    {
        WARN("没有找到该信号 %s", s.c_str());
        return *this;
    }

    return *this;
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
