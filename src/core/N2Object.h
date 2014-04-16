
#ifndef __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED
#define __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED

N2_BEGIN

class MetaObject
{
public:
    
    MetaObject();
    MetaObject(MetaObject const&);
    virtual ~MetaObject();
    
    inline operator metapointer_t () const {
        return _pmeta;
    }
    
    // 复制一个对象
    MetaObject copy() const;
    
protected:
    
    void setMeta(metapointer_t);
    metapointer_t getMeta() const;
    
    // 元数据是否可以修改
    bool metamutable;
    
private:
    
    mutable metapointer_t _pmeta;
    
};

class Object
: public MetaObject
{
    N2_NOCOPY(Object);
    
public:
    
    Object();
    virtual ~Object();
    
    // 引用计数
    Object* retain() const;
    bool release() const;

protected:
    
    mutable ulonglong _refcnt;
    
};

#define PRIVATE_CLASS(cls) cls##_Private

#define PRIVATE_IMPL(cls) \
class PRIVATE_CLASS(cls) \
{ \
friend class cls; \
cls* d_owner; \

#define PRIVATE_END \
};

#define PRIVATE_CONSTRUCT \
d_ptr = new private_t(); \
d_ptr->d_owner = this; \
d_ptr->init();

#define PRIVATE_DESTROY \
d_ptr->fin(); \
delete d_ptr; \
d_ptr = NULL;

#define PRIVATE(cls) \
private: \
friend class PRIVATE_CLASS(cls); \
typedef class PRIVATE_CLASS(cls) private_t; \
private_t *d_ptr;

template <typename T>
class Copyable
{
public:
    
    void copy(T const&);
    
};

N2_END

#endif
