/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "BU_SDWebImageCompat.h"

// This is used for operation management, but not for operation queue execute
@interface BU_SDImageCachesManagerOperation : NSOperation

@property (nonatomic, assign, readonly) NSUInteger pendingCount;

- (void)beginWithTotalCount:(NSUInteger)totalCount;
- (void)completeOne;
- (void)done;

@end
