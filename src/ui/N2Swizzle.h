
#ifndef __N2SWIZZLE_2282B8AA56384525A702AF0540D546EA_H_INCLUDED
#define __N2SWIZZLE_2282B8AA56384525A702AF0540D546EA_H_INCLUDED

#ifdef N2_OBJC

#import "core/N2Objc.h"

@protocol UIViewSwizzle <NSObject>

- (void)SWIZZLE_CALLBACK(layout_subviews);

@end

@interface UIKitSwizzle : NSObject

+ (void)Swizzles;

@end

#endif

#endif
