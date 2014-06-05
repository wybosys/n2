
#import "n2ui.h"

@protocol UIViewSwizzle <NSObject>
- (void)__swcb_layoutsubviews;
@end

@implementation UIView (swizzle)

static objc_swizzle_t __gs_uiview_layoutsubviews;

- (void)__swizzle_layoutsubviews {
    //objc_swizzle_invoke(__gs_uiview_layoutsubviews);
    [(id<UIViewSwizzle>)self __swcb_layoutsubviews];
}

+ (void)Swizzles {
    Class cls = [UIView class];
    class_safeSwizzleMethod(cls, @selector(layoutSubviews), @selector(__swizzle_layoutsubviews), &__gs_uiview_layoutsubviews);
}

@end

void uikit_swizzles()
{
    [UIView Swizzles];
}