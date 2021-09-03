/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "BU_SDWebImageCompat.h"

typedef NSData * _Nullable(^BU_SDWebImageCacheSerializerBlock)(UIImage * _Nonnull image, NSData * _Nullable data, NSURL * _Nullable imageURL);

/**
 This is the protocol for cache serializer.
 We can use a block to specify the cache serializer. But Using protocol can make this extensible, and allow Swift user to use it easily instead of using `@convention(block)` to store a block into context options.
 */
@protocol BU_SDWebImageCacheSerializer <NSObject>

- (nullable NSData *)cacheDataWithImage:(nonnull UIImage *)image originalData:(nullable NSData *)data imageURL:(nullable NSURL *)imageURL;

@end

/**
 A cache serializer class with block.
 */
@interface BU_SDWebImageCacheSerializer : NSObject <BU_SDWebImageCacheSerializer>

- (nonnull instancetype)initWithBlock:(nonnull BU_SDWebImageCacheSerializerBlock)block;
+ (nonnull instancetype)cacheSerializerWithBlock:(nonnull BU_SDWebImageCacheSerializerBlock)block;

@end
