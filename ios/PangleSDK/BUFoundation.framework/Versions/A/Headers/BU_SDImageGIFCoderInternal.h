/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "BU_SDWebImageCompat.h"
#import "BU_SDImageGIFCoder.h"

@interface BU_SDImageGIFCoder ()

- (float)sdBu_frameDurationAtIndex:(NSUInteger)index source:(nonnull CGImageSourceRef)source;

@end
