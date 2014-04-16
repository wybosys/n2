
# ifndef __N2PTR_6A07A1C955864B09AFA08B41338D6A88_H_INCLUDED
# define __N2PTR_6A07A1C955864B09AFA08B41338D6A88_H_INCLUDED

N2_BEGIN

template <typename T>
class Ptr
{
public:
    
    Ptr(T* p = NULL)
    :_p(p)
    {}
    
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
    : Ptr<T>(p)
    {
        refobj_set(this->_p, p);
    }
    
    ~RefPtr()
    {
        refobj_release(this->_p);
    }
    
};

template <typename T>
class PtrVector
{
public:
    
    PtrVector()
    {
        
    }
    
    ~PtrVector()
    {
        clear();
    }
    
    typedef typename ::std::vector<T*>::iterator iterator;
    typedef typename ::std::vector<T*>::const_iterator const_iterator;
    
    void clear()
    {
        for (iterator i = vector.begin(); i != vector.end(); ++i)
            delete *i;
        vector.clear();
    }
    
    iterator begin()
    {
        return vector.begin();
    }
    
    const_iterator begin() const
    {
        return vector.begin();
    }
    
    iterator end()
    {
        return vector.end();
    }
    
    const_iterator end() const
    {
        return vector.end();
    }
    
    void push_back(T* p)
    {
        vector.push_back(p);
    }
    
protected:
    
    ::std::vector<T*> vector;
};

N2_END

# endif
