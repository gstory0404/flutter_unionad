/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "BU_SDWebImageCompat.h"
#import <CoreGraphics/CoreGraphics.h>

/**
 These following graphics context method are provided to easily write cross-platform(AppKit/UIKit) code.
 For UIKit, these methods just call the same method in `UIGraphics.h`. See the documentation for usage.
 For AppKit, these methods use `NSGraphicsContext` to create image context and match the behavior like UIKit.
 */

/// Returns the current graphics context.
FOUNDATION_EXPORT CGContextRef __nullable BU_SDGraphicsGetCurrentContext(void) CF_RETURNS_NOT_RETAINED;
/// Creates a bitmap-based graphics context and makes it the current context.
FOUNDATION_EXPORT void BU_SDGraphicsBeginImageContext(CGSize size);
/// Creates a bitmap-based graphics context with the specified options.
FOUNDATION_EXPORT void BU_BU_SDGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
/// Removes the current bitmap-based graphics context from the top of the stack.
FOUNDATION_EXPORT void BU_SDGraphicsEndImageContext(void);
/// Returns an image based on the contents of the current bitmap-based graphics context.
FOUNDATION_EXPORT UIImage * __nullable BU_SDGraphicsGetImageFromCurrentImageContext(void);
