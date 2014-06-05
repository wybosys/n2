
#import <objc/objc.h>
#import <objc/runtime.h>

typedef struct _objc_swizzle_t objc_swizzle_t;

objc_swizzle_t* objc_swizzleNew();
BOOL class_existMethod(Class cls, SEL sel);
void class_swizzleMethod(Class c, SEL origs, SEL news);
IMP class_getImplementation(Class c, SEL sel);
BOOL class_safeSwizzleMethod(Class c, SEL sel, SEL tosel, objc_swizzle_t* data);
