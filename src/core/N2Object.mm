
#import "N2Core.h"
#import "N2Object.h"

N2_BEGIN

MetaObject::MetaObject()
: _pmeta(nil), metamutable(false)
{
    
}

MetaObject::~MetaObject()
{
    _pmeta = nil;
}

void MetaObject::setMeta(metapointer_t p)
{
    _pmeta = p;
}

metapointer_t MetaObject::getMeta() const
{
    return _pmeta;
}

Object::Object()
: _refcnt(1)
{
    
}

Object::~Object()
{

}

Object* Object::retain() const
{
    ++_refcnt;
    return const_cast<Object*>(this);
}

bool Object::release() const
{
    if (--_refcnt == 0)
    {
        delete this;
        return true;
    }
    return false;
}

N2_END
