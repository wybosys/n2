
# ifndef __N2PTR_6A07A1C955864B09AFA08B41338D6A88_H_INCLUDED
# define __N2PTR_6A07A1C955864B09AFA08B41338D6A88_H_INCLUDED

N2_BEGIN

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
    
    inline T& operator = (T* p)
    {
        _p = p;
        return *this;
    }
    
protected:
    
    T* _p;
    
};

template <typename T>
inline void refobj_set(T*& l, T* r)
{
    if (l == r) return;
    if (l) l->release();
    l = r;
    if (l) l->retain();
}

template <typename T>
inline void refobj_release(T*& l)
{
    if (l && l->release())
        l = NULL;
}

template <typename T>
inline void refobj_zero(T*& l)
{
    if (l) {
        l->release();
        l = NULL;
    }
}

template <typename T>
class RefPtr
: public Ptr<T>
{
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
