
#import "N2Ui.h"
#import "N2Swizzle.h"
#import "core/N2Objc.h"

@implementation UIView (swizzle)

static objc_swizzle_t sw_uiview_layoutsubviews;

- (void)swizzle_layoutsubviews {
    objc_swizzle_invoke(sw_uiview_layoutsubviews);
    [(id<UIViewSwizzle>)self SWIZZLE_CALLBACK(layout_subviews)];
}

- (void)SWIZZLE_CALLBACK(layout_subviews) {
    PASS;
}

+ (void)Swizzles {
    Class cls = [UIView class];
    class_safeSwizzleMethod(cls, @selector(layoutSubviews), @selector(swizzle_layoutsubviews), &sw_uiview_layoutsubviews);
}

@end

@implementation UIKitSwizzle

+ (void)Swizzles {
    [UIView Swizzles];
}

@end
