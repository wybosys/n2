
#ifndef __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED
#define __N2OBJECT_A004C0E18E484F9C9ECD099CA868182D_H_INCLUDED

N2_BEGIN

typedef struct _null_t null_type;
typedef struct _meta_t meta_type;

class Object;

class MetaObject
{
public:
    
    typedef meta_type meta_type;
    
    MetaObject();
    MetaObject(MetaObject const&);
    virtual ~MetaObject();
    
    inline operator metapointer_t () const {
        return getMeta();
    }
    
    // 复制一个对象
    MetaObject metacopy() const;
    
    // 从元数据中获取对象
    static Object* GetObject(metapointer_t);
    template <class T>
    static T* GetObject(metapointer_t m) {
        return dynamic_cast<T*>(GetObject(m));
    }
    
protected:
    
    // 设置元数据，不进行oc/c对象映射
    void setMeta(metapointer_t);
    // 绑定元数据，映射oc/c对象
    void bindMeta(metapointer_t);
    
    // 获取元数据
    virtual metapointer_t getMeta() const;
        
private:
    
    mutable metapointer_t _pmeta;
    
};

typedef struct _lockable_t lockable_type;

class MtxObject
{
public:
    
    typedef lockable_type lockable_type;
    
    MtxObject();
    ~MtxObject();
    
    void lock() const;
    void unlock() const;
    
    // 全局主资源保护
    static void Lock();
    static void Unlock();
    
private:
    
    mutable void* _mtx;
    
};

class AttachObject
{
public:
    
    class Weak
    : public ::std::map<::std::string, void*>
    {
    public:
        void set(::std::string const&, void*);
        void* get(::std::string const&) const;
    };
    
    class Strong
    : public ::std::map<::std::string, Object*>
    {
    public: ~Strong();
        void set(::std::string const&, Object*);
        Object* get(::std::string const&) const;
    };
    
    template <typename T, typename V>
    class found_type
    {
    public:
        
        inline operator V () const {
            return this->p->get(this->k);
        }
        
        template <typename UV>
        inline operator UV () const {
            return dynamic_cast<UV>((V)*this);
        }
        
        inline found_type& operator = (V v) {
            this->p->set(this->k, v);
            return *this;
        }
        
    protected:
        T* p;
        ::std::string k;
        friend class AttachObject;
    };
    
    found_type<Weak, void*> weak(::std::string const&);
    found_type<Strong, Object*> strong(::std::string const&);
    void* weak(::std::string const&) const;
    Object* strong(::std::string const&) const;
    
private:
    LazyInstance<Weak> _weak;
    LazyInstance<Strong> _strong;
};

typedef struct _ref_t ref_type;

class ReferenceObject
{
public:
    
    typedef ref_type ref_type;
    
    ReferenceObject();
    virtual ~ReferenceObject();
    
    // 引用计数
    ReferenceObject* retain() const;
    bool release() const;
    
private:
    
    mutable ulonglong _refcnt;
    
};

class Object
: public MetaObject,
public ReferenceObject,
public MtxObject,
public AttachObject
{
    N2_NOCOPY(Object);
    
public:
    
    Object();
    virtual ~Object();
    
    // 空函数占位
    inline void pass() {}
    
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
inline T* refobj_retain(T* l)
{
    if (l)
        l->retain();
    return l;
}

template <typename T>
inline void refobj_zero(T*& l)
{
    if (l) {
        l->release();
        l = NULL;
    }
}

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

typedef struct _copyable_t copyable_type;

template <typename T>
class Copyable
{
public:
    
    typedef copyable_type copyable_type;
    
    void copy(T const&);
    
};

N2_END

#endif
