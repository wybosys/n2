
# import "N2Core.h"
# import "N2SignalSlot.h"

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
    value = r.value;
    
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

Signals::Signals()
{
    
}

Signals::~Signals()
{
    
}

SObject::SObject()
{
    
}

SObject::~SObject()
{
    
}

Signals& SObject::signals() const
{
    if (sigs.isnull())
    {
        sigs = new Signals();
        mutable_cast(this)->init_signals();
    }
    return sigs;
}

void SObject::init_signals()
{
    PASS;
}

N2_END
