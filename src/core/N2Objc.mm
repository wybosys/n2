
#import "N2Core.h"
#import "N2Objc.h"

int kIOSMajorVersion = 0, kIOSMinorVersion = 0, kIOSVersion = 0;
BOOL kIOS7Above = NO, kIOS6Above = NO, kIOS5Above = NO;
BOOL kUIScreenIsRetina = NO;
UIScreenSizeType kUIScreenSizeType = kUIScreenSizeUnknown;
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
