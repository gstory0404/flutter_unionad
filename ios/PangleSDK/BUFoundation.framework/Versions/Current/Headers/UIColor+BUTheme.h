//
//  UIColor+BUTheme.h
//  BUAdSDK
//
//  Created by carl on 2017/8/15.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BU_Theme)
+ (UIColor *)bu_colorWithHEX:(NSUInteger)hex;
+ (UIColor *)bu_colorWithHEX:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)bu_colorWithHexString:(NSString *)color;
+ (UIColor *)bu_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
