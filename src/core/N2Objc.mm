
#import "N2Core.h"
#import "N2Objc.h"

N2_BEGIN_C

#import <objc/objc.h>
#import <objc/runtime.h>
#import <objc/objc-sync.h>

int kIOSMajorVersion = 0, kIOSMinorVersion = 0, kIOSVersion = 0;
BOOL kIOS7Above = NO, kIOS6Above = NO, kIOS5Above = NO;
BOOL kUIScreenIsRetina = NO;
UIScreenSizeType kUIScreenSizeType = kUIScreenSizeUnknown;
CGRect kUIScreenBounds = CGRectZero;
CGSize kUIScreenSize = CGSizeZero;
CGFloat kUIScreenScale = 0;
BOOL kDeviceIsRoot = NO, kDeviceRunningSimulator = NO;

void n2_objc_foundation() {
    // 判断屏幕尺寸
    UIScreen* scr = [UIScreen mainScreen];
    if (scr.scale == 1) {
        kUIScreenIsRetina = NO;
    } else {
        kUIScreenIsRetina = YES;
    }
    kUIScreenBounds = scr.bounds;
    kUIScreenSize = scr.applicationFrame.size;
    kUIScreenScale = scr.scale;
    if (scr.currentMode.size.height == 1136)
        kUIScreenSizeType = kUIScreenSize45;
    else
        kUIScreenSizeType = kUIScreenSize35;
    kDeviceRunningSimulator = ::n2::mask_check(kUIDeviceTypeSimulator, n2_uidevice_type());
    
    // 判断系统版本
    NSString* sysver = [UIDevice currentDevice].systemVersion;
    NSArray* arrvers = [sysver componentsSeparatedByString:@"."];
    kIOSMajorVersion = [arrvers.firstObject intValue];
    kIOSMinorVersion = [[arrvers objectAtIndex:1] intValue];
    kIOSVersion = kIOSMajorVersion << 16 | kIOSMinorVersion << 8;
    kIOS7Above = kIOSMajorVersion >= 7;
    kIOS6Above = kIOSMajorVersion >= 6;
    kIOS5Above = kIOSMajorVersion >= 5;
    kDeviceIsRoot = n2_uidevice_isroot();
    
# ifdef IOS7_FEATURES
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
# endif
}

UIDeviceType n2_uidevice_type() {
    NSString* model = [UIDevice currentDevice].model;
    UIDeviceType ret = kUIDeviceTypeUnknown;
    
    if ([model rangeOfString:@"iphone" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        ret |= kUIDeviceTypeIPhone;
    }
    else if ([model rangeOfString:@"ipad" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        ret |= kUIDeviceTypeIPad;
    }
    else if ([model rangeOfString:@"ipod" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        ret |= kUIDeviceTypeIPod;
    }
    
    if ([model rangeOfString:@"simulator" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        ret |= kUIDeviceTypeSimulator;
    }

    return ret;
}

bool n2_uidevice_isroot() {
    FILE* fp = popen("ls /var", "r");
    char buf[8];
    size_t len = fread(buf, 1, 8, fp);
    pclose(fp);
    return len != 0;
}

id class_callMethod(Class cls, SEL sel, ...) {
    Method mtd = class_getClassMethod(cls, sel);
    IMP imp = method_getImplementation(mtd);
    char ctype;
    method_getReturnType(mtd, &ctype, sizeof(char));
    
    va_list va;
    va_start(va, sel);
    id argu = va_arg(va, id);
    
    id ret = nil;
    if (ctype == _C_ID) {
        ret = (imp)(nil, sel, argu);
    } else {
        (imp)(nil, sel, argu);
    }
    
    va_end(va);
    return ret;
}

BOOL class_existMethod(Class cls, SEL sel) {
    Method mtd = class_getClassMethod(cls, sel);
    return mtd != NULL;
}

void class_swizzleMethod(Class c, SEL origs, SEL news) {
    Method origMethod = class_getInstanceMethod(c, origs);
    Method newMethod = class_getInstanceMethod(c, news);
    if(class_addMethod(c, origs, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, news, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

IMP class_getImplementation(Class c, SEL sel) {
    return method_getImplementation(class_getInstanceMethod(c, sel));
}

BOOL class_safeSwizzleMethod(Class c, SEL sel, SEL tosel, objc_swizzle_t* data) {
    data->cls = c;
    data->default_impl = class_getImplementation(data->cls, sel);
    data->default_sel = sel;
    if (data->default_impl == nil)
        return NO;
    data->next_impl = class_getImplementation(data->cls, tosel);
    if (data->next_impl == nil)
        return NO;
    class_swizzleMethod(data->cls, sel, tosel);
    return YES;
}

N2_END_C

N2OBJC_BEGIN

StaticPerform::StaticPerform(Class cls, SEL sel)
{
    class_callMethod(cls, sel);
}

N2OBJC_END
