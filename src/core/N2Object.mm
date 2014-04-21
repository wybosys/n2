
#import "N2Core.h"
#import "N2Object.h"
#import "N2Ptr.h"
#include <objc/runtime.h>
# import "N2Thread.h"

@interface N2MetaObject : NSObject

@property (nonatomic, assign) ::N2NS::Object* cxxobj;
- (void)clear;

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
    
    SUPER_DEALLOC;
}

- (void)clear {
    _cxxobj = NULL;
}

@end

N2_BEGIN

MetaObject::MetaObject()
: _pmeta(nil)
{
    
}

MetaObject::MetaObject(MetaObject const& r)
: _pmeta(nil)
{
    setMeta(r);
}

MetaObject::~MetaObject()
{
    // 需要安全的释放掉cxx对象
    N2MetaObject* mo = objc_getAssociatedObject(getMeta(), &kMetaObjectKey);
    if (mo) {
        [mo clear]; // 不能直接=nil，因为此时已经进入destroy流程，直接=nil，会引起重复release
        objc_setAssociatedObject(getMeta(), &kMetaObjectKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
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
        mo.cxxobj = dynamic_cast<Object*>(this);
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

MetaObject MetaObject::metacopy() const
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

void AttachObject::Weak::set(::std::string const& k, void *p)
{
    insert(::std::make_pair(k, p));
}

void* AttachObject::Weak::get(::std::string const& k) const
{
    auto found = find(k);
    if (found == end())
        return NULL;
    return found->second;
}

AttachObject::Strong::~Strong()
{
    for (auto i = begin(); i != end(); ++i)
        refobj_zero(i->second);
}

void AttachObject::Strong::set(::std::string const& k, Object* p)
{
    Object* t = get(k);
    refobj_release(t);
    insert(::std::make_pair(k, refobj_retain(p)));
}

Object* AttachObject::Strong::get(::std::string const& k) const
{
    auto found = find(k);
    if (found == end())
        return NULL;
    return found->second;
}

void* AttachObject::weak(::std::string const& k) const
{
    if (_weak.isnull())
        return NULL;
    return NULL;
}

AttachObject::found_type<AttachObject::Weak, void*> AttachObject::weak(::std::string const& k)
{
    MtxObject::Lock();
    if (_weak.isnull())
        _weak = new Weak();
    MtxObject::Unlock();

    found_type<Weak, void*> ret;
    ret.p = _weak;
    ret.k = k;
    return ret;
}

Object* AttachObject::strong(::std::string const& k) const
{
    if (_strong.isnull())
        return NULL;
    return NULL;
}

AttachObject::found_type<AttachObject::Strong, Object*> AttachObject::strong(::std::string const& k)
{
    MtxObject::Lock();
    if (_strong.isnull())
        _strong = new Strong();
    MtxObject::Unlock();
    
    found_type<Strong, Object*> ret;
    ret.p = _strong;
    ret.k = k;
    return ret;
}

N2_END
