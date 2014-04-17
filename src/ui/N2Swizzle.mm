
#import "N2Ui.h"
#import "N2Swizzle.h"
#import "core/N2Objc.h"

@implementation UIView (swizzle)

static objc_swizzle_t sw_uiview_layoutsubviews;

- (void)swizzle_layoutsubviews {
    objc_swizzle_invoke(sw_uiview_layoutsubviews);
    [(id<UIViewSwizzle>)self SWIZZLE_CALLBACK(layout_subviews)];
}

- (void)SWIZZLE_CALLBACK(layout_subviews) {}

+ (void)Swizzles {
    Class cls = [UIView class];
    class_safeSwizzleMethod(cls, @selector(layoutSubviews), @selector(swizzle_layoutsubviews), &sw_uiview_layoutsubviews);
}

@end

@implementation UIViewController (swizzle)

static objc_swizzle_t sw_uivc_viewloaded;

- (void)swizzle_viewloaded {
    objc_swizzle_invoke(sw_uivc_viewloaded);
    [(id<UIViewControllerSwizzle>)self SWIZZLE_CALLBACK(view_loaded)];
}

- (void)SWIZZLE_CALLBACK(view_loaded) {}

+ (void)Swizzles {
    Class cls = [UIViewController class];
    class_safeSwizzleMethod(cls, @selector(viewDidLoad), @selector(swizzle_viewloaded), &sw_uivc_viewloaded);
}

@end

@implementation UINavigationController (swizzle)

+ (void)Swizzles {
    PASS;
}

@end

@implementation UIKitSwizzle

+ (void)Swizzles {
    [UIView Swizzles];
    [UIViewController Swizzles];
    [UINavigationController Swizzles];
}

@end
