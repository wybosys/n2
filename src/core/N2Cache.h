
#ifndef __N2CACHE_43E73B8270034D8C972F1BB5C02AC669_H_INCLUDED
#define __N2CACHE_43E73B8270034D8C972F1BB5C02AC669_H_INCLUDED

N2CORE_BEGIN

class ObjectCache
{
public:
    
    ObjectCache();
    ~ObjectCache();
    
    ReferenceObject& add(::std::string const& k, ::std::function<RefPtr<ReferenceObject>()>);
    ReferenceObject& add(::std::string const& k, ReferenceObject*);
    ReferenceObject* find(::std::string const&) const;
    RefPtr<ReferenceObject> pop(::std::string const&);
    
protected:
    
    ::std::map<::std::string, ReferenceObject*> _m;
    
};

N2CORE_END

#endif
