
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

N2_END

# endif
