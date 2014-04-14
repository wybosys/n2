
#ifndef __N2OBJC_30F244BE14614C6B91E5FAC1386653DC_H_INCLUDED
#define __N2OBJC_30F244BE14614C6B91E5FAC1386653DC_H_INCLUDED

#import <UIKit/UIKit.h>

extern int kIOSMajorVersion, kIOSMinorVersion, kIOSVersion;
extern BOOL kIOS7Above, kIOS6Above, kIOS5Above;
extern BOOL kUIScreenIsRetina;
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
extern UIDeviceType n2_uidevice_type();
extern bool n2_uidevice_isroot();

extern void n2_objc_foundation();

#endif
