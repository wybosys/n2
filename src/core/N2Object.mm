
#import "N2Core.h"
#import "N2Object.h"

N2_BEGIN

Object::Object()
: _refcount(1)
{
    
}

Object::~Object()
{
    
}

Object* Object::retain() const
{
    ++_refcount;
    return const_cast<Object*>(this);
}

bool Object::release() const
{
    if (--_refcount == 0)
    {
        delete this;
        return true;
    }
    return false;
}

N2_END
