
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
    
    inline operator T () const
    {
        return _v;
    }
    
    inline operator T& ()
    {
        return _v;
    }
    
    inline T& operator * ()
    {
        return _v;
    }
    
    inline T operator * () const
    {
        return _v;
    }
    
    inline Value& operator = (T const& v)
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
    
    Ptr(T* p = NULL)
    :_p(p)
    {
    }
    
    inline operator T* ()
    {
        return _p;
    }
    
    inline operator T const* () const
    {
        return _p;
    }
    
    inline operator T& ()
    {
        return *_p;
    }
    
    inline operator T const& () const
    {
        return *_p;
    }
    
    inline T& operator * ()
    {
        return *_p;
    }
    
    inline T const& operator * () const
    {
        return *_p;
    }
    
    inline T* operator -> ()
    {
        return _p;
    }
    
    inline T const* operator -> () const
    {
        return _p;
    }
    
    inline bool isnull() const
    {
        return _p == NULL;
    }
    
    inline Ptr& operator = (T* p)
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
};

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
    
    inline LazyInstance& operator = (T* p)
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
    
    template <typename A0>
    Instance(A0 const& a0)
    {
        T* o = new T(a0);
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
    
    template <typename A0>
    RefInstance(A0 const& a0)
    {
        T* o = new T(a0);
        refobj_set(this->_p, o);
        o->release();
    }
    
};

template <typename T>
class PtrVector
: protected ::std::vector<T*>
{
    typedef ::std::vector<T*> vector_t;
    
public:
    
    PtrVector()
    {
        
    }
    
    ~PtrVector()
    {
        clear();
    }
    
    using vector_t::begin;
    using vector_t::end;
    using vector_t::push_back;
    
    void clear()
    {
        for (auto i = begin(); i != end(); ++i)
            delete *i;
        vector_t::clear();
    }
    
};

template <typename K, typename T>
class PtrMap
: protected ::std::map<K, T*>
{
    typedef ::std::map<K, T*> map_t;
    
public:
    
    PtrMap()
    {
        
    }
    
    ~PtrMap()
    {
        clear();
    }
    
    using map_t::begin;
    using map_t::end;
    using map_t::find;
    using map_t::operator [];
    
    void clear()
    {
        for (auto i = begin(); i != end(); ++i)
            delete i->second;
        map_t::clear();
    }
    
};

N2_END

# endif
