
#import <stdlib.h>
#import "N2Swizzle.h"

objc_swizzle_t* objc_swizzleNew() {
    return (objc_swizzle_t*)malloc(sizeof(objc_swizzle_t));
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

@implementation NSObject (extension)

static char __nsobjdynkey_signals = 0;

- (id)_inner_signals {
    id ret = objc_getAssociatedObject(self, &__nsobjdynkey_signals);
    return ret;
}

- (void)set_inner_signals:(id)signals {
    objc_setAssociatedObject(self, &__nsobjdynkey_signals, signals, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)invokeSelector:(SEL)aSelector withObject:(id)obj {
    [self performSelector:aSelector withObject:obj];
}

@end
