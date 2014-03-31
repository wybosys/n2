
#ifndef __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED
#define __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED

N2_BEGIN

class Object
{
    N2_NOCOPY(Object);
    
public:
    
    Object();
    virtual ~Object();
    
    // 引用计数
    Object* retain() const;
    bool release() const;

private:
    
    mutable ulonglong _refcount;
};

N2_END

#endif
