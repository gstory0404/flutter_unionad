/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "BU_SDWebImageCompat.h"

#if SD_MAC

#import "UIImage+BUTransform.h"

@interface NSBezierPath (RoundedCorners)

/**
 Convenience way to create a bezier path with the specify rounding corners on macOS. Same as the one on `UIBezierPath`.
 */
+ (nonnull instancetype)sdBu_bezierPathWithRoundedRect:(NSRect)rect byRoundingCorners:(BU_SDRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

@end

#endif
