
#ifndef __N2KERNEL_A32EA0AE2D8245E49F1442C4F9B20793_H_INCLUDED
#define __N2KERNEL_A32EA0AE2D8245E49F1442C4F9B20793_H_INCLUDED

#define N2_NAME nn
#define N2NS N2_NAME

#ifdef __cplusplus
# define N2_CXX 1
#else
# define N2_C 1
#endif

#ifdef __OBJC__
# define N2_OBJC 1
#endif

#define SPACE {}
#define COMMA ,
#define PASS
#define TODO

#ifdef N2_CXX
# define N2_BEGIN namespace N2NS {
# define N2_END }
# define N2_BEGIN_C extern "C" {
# define N2_END_C }
# define N2_BEGIN_NS(ns) N2_BEGIN namespace ns {
# define N2_END_NS } N2_END
# define N2_USE using namespace N2NS;

# include <string>
# include <vector>
# include <list>
# include <set>
# include <deque>
# include <stack>
# include <map>
# include <mutex>
# include <thread>
#else
# define N2_BEGIN
# define N2_END
# define N2_BEGIN_C
# define N2_END_C
# define N2_BEIGN_NS(ns)
# define N2_END_NS
#endif

#define EXTERN extern

#if defined(_DEBUG) || defined(_DEBUG_) || defined(DEBUG)
# define TRUEDEBUG_MODE
# define PRECOMP_DEBUG_MODE
#endif

#ifdef PRECOMP_DEBUG_MODE
# define DEBUG_MODE
# define DEBUG_EXPRESS(exp) exp
# define RELEASE_EXPRESS(exp) {}
# define DEBUG_SYMBOL(sym) sym
# define RELEASE_SYMBOL(sym)
# define TEST_EXPRESS(exp) exp
#else
# define RELEASE_MODE
# define DEBUG_EXPRESS(exp) {}
# define RELEASE_EXPRESS(exp) exp
# define DEBUG_SYMBOL(sym)
# define RELEASE_SYMBOL(sym) sym
#endif

#if defined(__LP64__) && __LP64__
# define N2_64
# define X64SYMBOL(exp) exp
# define X32SYMBOL(exp)
#else
# define N2_32
# define X64SYMBOL(exp)
# define X32SYMBOL(exp) exp
#endif

#define TRIEXPRESS(exp, v0, v1) ((exp) ? (v0) : (v1))

#ifdef N2LIB
# define N2LIB 1
# define hybrid public
# define LIBSYMBOL(exp) exp
# define NLIBSYMBOL(exp)
#else
# define hybrid protected
# define LIBSYMBOL(exp)
# define NLIBSYMBOL(exp) exp
typedef struct _metapointer_t *metapointer_t;
#endif

#define N2_NOCOPY(cls) \
private: cls(cls const&); cls& operator = (cls const&);

#define MACROVALUE(exp) exp
#define _MACROCOMBINE(l, r) l ## r
#define MACROCOMBINE(l, r) _MACROCOMBINE(l, r)
#define AUTOVARIANTNAME MACROCOMBINE(_autovariant_, __LINE__)

N2_BEGIN

typedef long long longlong;
typedef unsigned long long ulonglong;
typedef signed int dword;
typedef unsigned int uint, udword;
typedef unsigned long ulong;
typedef unsigned char ubyte, uchar, byte;
typedef signed char sbyte;
typedef unsigned short ushort, uword;
typedef signed short word;
typedef X32SYMBOL(float) X64SYMBOL(double) real;

#ifdef N2_OBJC
# ifdef N2LIB
typedef id metapointer_t;
# endif

# define API_IOS8
# define API_IOS7
# define API_IOS6
# define API_IOS5

# if __has_feature(objc_arc) == 1
#   define N2_OBJC_ARC 1
# endif

# ifdef N2_OBJC_ARC
#  define OBJC_RELEASE(o) {o=o;}
#  define OBJC_AUTORELEASE(o) {}
#  define OBJC_CONSIGN(o) {}
#  define SUPER_DEALLOC {}
#  define MUST_ARC
#  define MUST_NOARC error "must turn OFF arc"
# else
#  define NOARC_TODO
#  define MUST_ARC error "must turn ON arc"
#  define MUST_NOARC
#  define OBJC_RELEASE(o) { int rc = o.retainCount; [o release]; if (rc == 1) o = nil; }
#  define OBJC_AUTORELEASE(o) [o autorelease]
#  define OBJC_CONSIGN(o) [[o retain] autorelease]
#  define SUPER_DEALLOC {[super dealloc];}
# endif

# ifdef __IPHONE_7_0
#  define IOS_SDK_7 1
# endif

# define IOS7_FEATURES

# if !defined(IOS_SDK_7) && defined(IOS7_FEATURES)
#  undef IOS7_FEATURES
# endif

#else
typedef void* metapointer_t;
#endif

extern void dlog(char const*, ...);
extern void dinfo(char const*, ...);
extern void dwarn(char const*, ...);
extern void dfatal(char const*, ...);
extern void sleep_seconds(float);

#ifdef DEBUG_MODE
# define LOG N2NS::dlog
# define INFO N2NS::dinfo
# define WARN N2NS::dwarn
# define FATAL N2NS::dfatal
#else
# define LOG(fmt, ...) SPACE
# define INFO(fmt, ...) SPACE
# define WARN(fmt, ...) SPACE
# define FATAL(fmt, ...) SPACE
#endif

inline bool mask_check(uint mask, uint val)
{
    return (val & mask) == mask;
}

inline uint mask_set(uint mask, uint val)
{
    if (mask_check(mask, val))
        return val;
    val |= mask;
    return val;
}

inline uint mask_unset(uint mask, uint val)
{
    if (!mask_check(mask, val))
        return val;
    val ^= mask;
    return val;
}

#ifdef N2_CXX

# define LIBONLY NLIBSYMBOL(= delete)
# define OVERRIDE override
# define FINAL final

template <typename T>
inline T* mutable_cast(T const* p)
{
    return const_cast<T*>(p);
}

template <typename T>
inline T& mutable_cast(T const& p)
{
    return const_cast<T&>(p);
}

# define INTERFACE(cls, exp) \
class I##cls \
{ \
public: \
typedef I##cls interface_type; \
virtual ~I##cls() {} \
exp \
};

typedef struct { enum { VALUE = true }; } true_type;
typedef struct { enum { VALUE = false }; } false_type;

template <typename  ...T>
struct type_hybrid
: public T...
{};

extern ::std::string __typeinfo_name_humaned(::std::string const&);

# define ptrcall(p, exp) { if (p) (p)->exp; }

#else

# define ptrcall(p, exp) { if (p) { exp; } }

#endif

N2_END

#endif
