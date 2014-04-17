
#ifndef __N2OBJC_30F244BE14614C6B91E5FAC1386653DC_H_INCLUDED
#define __N2OBJC_30F244BE14614C6B91E5FAC1386653DC_H_INCLUDED

#import <UIKit/UIKit.h>

N2_BEGIN_C

extern int kIOSMajorVersion, kIOSMinorVersion, kIOSVersion;
extern BOOL kIOS7Above, kIOS6Above, kIOS5Above;
extern BOOL kUIScreenIsRetina;
extern CGRect kUIScreenBounds;
extern CGSize kUIScreenSize;
extern CGFloat kUIScreenScale;
extern BOOL kDeviceIsRoot, kDeviceRunningSimulator;

typedef enum {
    kUIScreenSizeUnknown,
    kUIScreenSize35,
    kUIScreenSize45,
} UIScreenSizeType;
extern UIScreenSizeType kUIScreenSizeType;

enum {
    kUIDeviceTypeUnknown,
    kUIDeviceTypeIPhone = 0x1000,
    kUIDeviceTypeIPad = 0x2000,
    kUIDeviceTypeIPod = 0x3000,
    kUIDeviceTypeSimulator = 0x0001,
};
typedef uint UIDeviceType;
EXTERN UIDeviceType n2_uidevice_type();
EXTERN bool n2_uidevice_isroot();

EXTERN void n2_objc_foundation();

EXTERN id class_callMethod(Class cls, SEL sel, ...);
EXTERN BOOL class_existMethod(Class cls, SEL sel);
EXTERN void class_swizzleMethod(Class c, SEL origs, SEL news);
EXTERN IMP class_getImplementation(Class cls, SEL sel);

typedef struct _objc_swizzle_t
{
    Class cls;
    IMP default_impl;
    SEL default_sel;
    IMP next_impl;
} objc_swizzle_t;

# define objc_swizzle_invoke(obj, ...) (obj.default_impl)(self, obj.default_sel, ## __VA_ARGS__);

# define SWIZZLE_CALLBACK(which) __swizzle_callback_##which

N2_END_C

#endif
