
#import "N2Core.h"
#import "N2Object.h"

N2_BEGIN

MetaObject::MetaObject()
: _pmeta(nil), metamutable(false)
{
    
}

MetaObject::MetaObject(MetaObject const& r)
: _pmeta(nil)
{
    setMeta(r);
    metamutable = r.metamutable;
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

MetaObject MetaObject::copy() const
{
    id obj = [_pmeta copy];
    MetaObject ret;
    ret.setMeta(obj);
    return ret;
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
