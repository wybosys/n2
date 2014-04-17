
#import "N2Core.h"
#import "N2Object.h"
#import "N2Ptr.h"
#include <objc/runtime.h>
# import "N2Thread.h"

@interface N2MetaObject : NSObject

@property (nonatomic, assign) ::N2NS::Object* cxxobj;

@end

@implementation N2MetaObject

static char kMetaObjectKey = 0;

- (void)setCxxobj:(::N2NS::Object*)cxxobj {
    N2_USE;
    refobj_set(_cxxobj, cxxobj);
}

- (void)dealloc {
    N2_USE;
    refobj_zero(_cxxobj);
}

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

void MetaObject::bindMeta(metapointer_t p)
{
    setMeta(p);
    
    N2MetaObject* mo = nil;
    if (p)
    {
        mo = objc_getAssociatedObject(getMeta(), &kMetaObjectKey);
        if (mo == nil)
            mo = [[N2MetaObject alloc] init];
        mo.cxxobj = (Object*)this;
    }
    objc_setAssociatedObject(p, &kMetaObjectKey, mo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

metapointer_t MetaObject::getMeta() const
{
    return _pmeta;
}

Object* MetaObject::GetObject(metapointer_t m)
{
    N2MetaObject* mo = objc_getAssociatedObject(m, &kMetaObjectKey);
    return mo.cxxobj;
}

MetaObject MetaObject::copy() const
{
    id obj = [_pmeta copy];
    MetaObject ret;
    ret.setMeta(obj);
    return ret;
}

static Mutex gs_mtx_MtxObject;

MtxObject::MtxObject()
: _mtx(NULL)
{
    
}

MtxObject::~MtxObject()
{
    gs_mtx_MtxObject.lock();
    delete (Mutex*)_mtx;
    gs_mtx_MtxObject.unlock();
}

void MtxObject::lock() const
{
    gs_mtx_MtxObject.lock();
    if (_mtx == NULL)
        _mtx = new Mutex();
    gs_mtx_MtxObject.unlock();
    ((Mutex*)_mtx)->lock();
}

void MtxObject::unlock() const
{
    ((Mutex*)_mtx)->unlock();
}

void MtxObject::Lock()
{
    gs_mtx_MtxObject.lock();
}

void MtxObject::Unlock()
{
    gs_mtx_MtxObject.unlock();
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
