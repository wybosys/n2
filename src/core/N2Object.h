
#ifndef __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED
#define __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED

N2_BEGIN

class MetaObject
{
public:
    
    MetaObject();
    virtual ~MetaObject();
    
protected:
    
    void setMeta(metapointer_t);
    metapointer_t getMeta() const;
    
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

N2_END

#endif
