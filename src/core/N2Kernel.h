
#ifndef __N2KERNEL_A32EA0AE2D8245E49F1442C4F9B20793_H_INCLUDED
#define __N2KERNEL_A32EA0AE2D8245E49F1442C4F9B20793_H_INCLUDED

#define N2_NAME n2

#ifdef __cplusplus
# define N2_CXX 1
#else
# define N2_C 1
#endif

#ifdef __OBJC__
# define N2_OBJC 1
#endif

#ifdef N2_CXX
# define N2_BEGIN namespace N2_NAME {
# define N2_END }
# define N2_BEGIN_C exten "C" {
# define N2_END_C }
# define N2_BEGIN_NS(ns) N2_BEGIN namespace ns {
# define N2_END_NS } N2_END
#else
# define N2_BEGIN
# define N2_END
# define N2_BEGIN_C
# define N2_END_C
# define N2_BEIGN_NS(ns)
# define N2_END_NS
#endif

#define PASS
#define TODO

#define N2_NOCOPY(cls) private: cls(cls const&); cls& operator = (cls const&);

N2_BEGIN

typedef long long longlong;
typedef unsigned long long ulonglong;
typedef signed int dword;
typedef unsigned int uint, udword;
typedef unsigned long ulong;
typedef unsigned char ubyte, uchar;
typedef signed char sbyte;
typedef unsigned short ushort, uword;
typedef signed short word;

#ifdef N2_OBJC
typedef id metapointer_t;
#else
typedef void* metapointer_t;
#endif

N2_END

#endif
