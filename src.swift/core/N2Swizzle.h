
#import <objc/objc.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

typedef struct _objc_swizzle_t
{
    Class cls;
    IMP default_impl;
    SEL default_sel;
    IMP next_impl;
} objc_swizzle_t;

objc_swizzle_t* objc_swizzleNew();
BOOL class_existMethod(Class cls, SEL sel);
void class_swizzleMethod(Class c, SEL origs, SEL news);
IMP class_getImplementation(Class c, SEL sel);
BOOL class_safeSwizzleMethod(Class c, SEL sel, SEL tosel, objc_swizzle_t* data);

#define SWIZZLE_CALLBACK(which) __swizzle_callback_##which
//#define objc_swizzle_invoke(obj, ...) (obj.default_impl)(self, obj.default_sel, ## __VA_ARGS__);
#define objc_swizzle_invoke(obj, ...) (obj.default_impl)();

@interface NSObject (extension)

@property (nonatomic, retain) id _inner_signals;

@end
