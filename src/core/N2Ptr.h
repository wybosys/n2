
# ifndef __N2PTR_6A07A1C955864B09AFA08B41338D6A88_H_INCLUDED
# define __N2PTR_6A07A1C955864B09AFA08B41338D6A88_H_INCLUDED

N2_BEGIN

template <typename T>
class Value
{
public:
    
    Value()
    : _v(0)
    {}
    
    operator T () const
    {
        return _v;
    }
    
    operator T& ()
    {
        return _v;
    }
    
    T& operator * ()
    {
        return _v;
    }
    
    T operator * () const
    {
        return _v;
    }
    
    Value& operator = (T const& v)
    {
        _v = v;
        return *this;
    }
    
protected:
    
    T _v;
};

template <typename T>
class Ptr
{
public:
    
    typedef T type;
    
    Ptr(T* p = NULL)
    :_p(p)
    {
    }
    
    operator T* ()
    {
        return _p;
    }
    
    operator T const* () const
    {
        return _p;
    }
    
    operator T& ()
    {
        return *_p;
    }
    
    operator T const& () const
    {
        return *_p;
    }
    
    T& operator * ()
    {
        return *_p;
    }
    
    T const& operator * () const
    {
        return *_p;
    }
    
    T* operator -> ()
    {
        return _p;
    }
    
    T const* operator -> () const
    {
        return _p;
    }
    
    bool isnull() const
    {
        return _p == NULL;
    }
    
    Ptr& operator = (T* p)
    {
        _p = p;
        return *this;
    }
    
protected:
    
    T* _p;
    
};

template <typename T>
class RefPtr
: public Ptr<T>
{
    typedef Ptr<T> super_type;
    
public:
    
    RefPtr(T* p = NULL)
    {
        refobj_set(this->_p, p);
    }
    
    ~RefPtr()
    {
        refobj_release(this->_p);
    }
    
    RefPtr& operator = (T* r)
    {
        refobj_set(this->_p, r);
        return *this;
    }
    
    RefPtr& retain()
    {
        refobj_retain(this->_p);
        return *this;
    }
};

template <typename T>
struct regular_type
{
    typedef T type;
};

template <typename T>
struct regular_type<Ptr<T> >
{
    typedef T type;
};

# define REFPTR_PROTECT(ptr) ::N2NS::RefPtr<::std::remove_pointer<regular_type<decltype(ptr)>::type>::type> AUTOVARIANTNAME;

template <typename T>
inline void obj_release(T*& p)
{
    if (p) {
        delete p;
        p = NULL;
    }
}

template <typename T>
class LazyInstance
: public Ptr<T>
{
public:
    
    LazyInstance()
    {}
    
    ~LazyInstance()
    {
        obj_release(this->_p);
    }
    
    LazyInstance& operator = (T* p)
    {
        obj_release(this->_p);
        this->_p = p;
        return *this;
    }
    
};

template <typename T>
class Instance
: public LazyInstance<T>
{
public:
    
    Instance()
    {
        T* o = new T();
        this->_p = o;
    }
    
    template <typename A0, typename... AT>
    Instance(A0 const& a0, AT... at)
    {
        T* o = new T(a0, at...);
        this->_p = o;
    }
    
};

template <typename T>
class RefInstance
: public RefPtr<T>
{
public:
    
    RefInstance()
    {
        T* o = new T();
        refobj_set(this->_p, o);
        o->release();
    }
    
    template <typename A0, typename... AT>
    RefInstance(A0 const& a0, AT... at)
    {
        T* o = new T(a0, at...);
        refobj_set(this->_p, o);
        o->release();
    }
    
};

N2_END

# endif
