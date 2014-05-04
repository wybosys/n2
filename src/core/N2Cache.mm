
#include "N2Core.h"
#include "N2Cache.h"

N2CORE_BEGIN

ObjectCache::ObjectCache()
{
    
}

ObjectCache::~ObjectCache()
{
    for (auto i : _m)
        refobj_release(i.second);
    _m.clear();
}

void ObjectCache::add(::std::string const& k, ::std::function<ReferenceObject*()> fc)
{
    auto found = _m.find(k);
    if (found == _m.end())
    {
        _m[k] = fc();
    }
}

void ObjectCache::add(::std::string const& k, ReferenceObject* o)
{
    auto found = _m.find(k);
    if (found == _m.end())
    {
        _m[k] = refobj_retain(o);
    }
    else
    {
        refobj_set(found->second, o);
    }
}

ReferenceObject* ObjectCache::find(::std::string const& k) const
{
    auto found = _m.find(k);
    if (found == _m.end())
        return NULL;
    return found->second;
}

RefPtr<ReferenceObject> ObjectCache::pop(::std::string const& k)
{
    auto found = _m.find(k);
    if (found == _m.end())
        return NULL;
    RefPtr<ReferenceObject> ret = found->second;
    refobj_release(found->second);
    _m.erase(found);
    return ret;
}

N2CORE_END
