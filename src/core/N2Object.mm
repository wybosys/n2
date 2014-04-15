
#import "N2Core.h"
#import "N2Object.h"
#import "N2Ptr.h"
#include <objc/runtime.h>

@interface N2MetaObject : NSObject

@property (nonatomic, assign) ::N2NS::Object* cxxobj;

@end

@implementation N2MetaObject

- (void)setCxxobj:(::N2NS::Object*)cxxobj {
    N2_USE;
    refobj_set(_cxxobj, cxxobj);
}

- (void)dealloc {
    N2_USE;
    refobj_zero(_cxxobj);
}

/*
 N2MetaObject* mo = nil;
 if (p)
 {
 mo = objc_getAssociatedObject(getMeta(), &kMetaObjectKey);
 if (mo == nil)
 mo = [[N2MetaObject alloc] init];
 mo.cxxobj = this;
 }
 objc_setAssociatedObject(getMeta(), &kMetaObjectKey, mo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 */

@end

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
    setMeta(nil);
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
