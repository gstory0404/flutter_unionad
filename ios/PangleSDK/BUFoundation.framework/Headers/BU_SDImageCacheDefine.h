/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "BU_SDWebImageCompat.h"
#import "BU_SDWebImageOperation.h"
#import "BU_SDWebImageDefine.h"

/// Image Cache Type
typedef NS_ENUM(NSInteger, BU_SDImageCacheType) {
    /**
     * For query and contains op in response, means the image isn't available in the image cache
     * For op in request, this type is not available and take no effect.
     */
    BU_SDImageCacheTypeNone,
    /**
     * For query and contains op in response, means the image was obtained from the disk cache.
     * For op in request, means process only disk cache.
     */
    BU_SDImageCacheTypeDisk,
    /**
     * For query and contains op in response, means the image was obtained from the memory cache.
     * For op in request, means process only memory cache.
     */
    BU_SDImageCacheTypeMemory,
    /**
     * For query and contains op in response, this type is not available and take no effect.
     * For op in request, means process both memory cache and disk cache.
     */
    BU_SDImageCacheTypeAll
};

typedef void(^SDImageCacheCheckCompletionBlock)(BOOL isInCache);
typedef void(^SDImageCacheCalculateSizeBlock)(NSUInteger fileCount, NSUInteger totalSize);
typedef NSString * _Nullable (^SDImageCacheAdditionalCachePathBlock)(NSString * _Nonnull key);
typedef void(^BU_SDImageCacheQueryCompletionBlock)(UIImage * _Nullable image, NSData * _Nullable data, BU_SDImageCacheType cacheType);
typedef void(^BU_SDImageCacheContainsCompletionBlock)(BU_SDImageCacheType containsCacheType);

/**
 This is the built-in decoding process for image query from cache.
 @note If you want to implement your custom loader with `queryImageForKey:options:context:completion:` API, but also want to keep compatible with SDWebImage's behavior, you'd better use this to produce image.
 
 @param imageData The image data from the cache. Should not be nil
 @param cacheKey The image cache key from the input. Should not be nil
 @param options The options arg from the input
 @param context The context arg from the input
 @return The decoded image for current image data query from cache
 */
FOUNDATION_EXPORT UIImage * _Nullable BU_SDImageCacheDecodeImageData(NSData * _Nonnull imageData, NSString * _Nonnull cacheKey, BU_SDWebImageOptions options, SDWebImageContext * _Nullable context);

/**
 This is the image cache protocol to provide custom image cache for `SDWebImageManager`.
 Though the best practice to custom image cache, is to write your own class which conform `SDMemoryCache` or `SDDiskCache` protocol for `SDImageCache` class (See more on `SDImageCacheConfig.memoryCacheClass & SDImageCacheConfig.diskCacheClass`).
 However, if your own cache implementation contains more advanced feature beyond `SDImageCache` itself, you can consider to provide this instead. For example, you can even use a cache manager like `SDImageCachesManager` to register multiple caches.
 */
@protocol BU_SDImageCache <NSObject>

@required
/**
 Query the cached image from image cache for given key. The operation can be used to cancel the query.
 If image is cached in memory, completion is called synchronously, else aynchronously and depends on the options arg (See `SDWebImageQueryDiskSync`)

 @param key The image cache key
 @param options A mask to specify options to use for this query
 @param context A context contains different options to perform specify changes or processes, see `BU_SDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
 @param completionBlock The completion block. Will not get called if the operation is cancelled
 @return The operation for this query
 */
- (nullable id<BU_SDWebImageOperation>)queryImageForKey:(nullable NSString *)key
                                             options:(BU_SDWebImageOptions)options
                                             context:(nullable SDWebImageContext *)context
                                          completion:(nullable BU_SDImageCacheQueryCompletionBlock)completionBlock;

/**
 Store the image into image cache for the given key. If cache type is memory only, completion is called synchronously, else aynchronously.

 @param image The image to store
 @param imageData The image data to be used for disk storage
 @param key The image cache key
 @param cacheType The image store op cache type
 @param completionBlock A block executed after the operation is finished
 */
- (void)storeImage:(nullable UIImage *)image
         imageData:(nullable NSData *)imageData
            forKey:(nullable NSString *)key
         cacheType:(BU_SDImageCacheType)cacheType
        completion:(nullable SDWebImageNoParamsBlock)completionBlock;

/**
 Remove the image from image cache for the given key. If cache type is memory only, completion is called synchronously, else aynchronously.

 @param key The image cache key
 @param cacheType The image remove op cache type
 @param completionBlock A block executed after the operation is finished
 */
- (void)removeImageForKey:(nullable NSString *)key
                cacheType:(BU_SDImageCacheType)cacheType
               completion:(nullable SDWebImageNoParamsBlock)completionBlock;

/**
 Check if image cache contains the image for the given key (does not load the image). If image is cached in memory, completion is called synchronously, else aynchronously.

 @param key The image cache key
 @param cacheType The image contains op cache type
 @param completionBlock A block executed after the operation is finished.
 */
- (void)containsImageForKey:(nullable NSString *)key
                  cacheType:(BU_SDImageCacheType)cacheType
                 completion:(nullable BU_SDImageCacheContainsCompletionBlock)completionBlock;

/**
 Clear all the cached images for image cache. If cache type is memory only, completion is called synchronously, else aynchronously.

 @param cacheType The image clear op cache type
 @param completionBlock A block executed after the operation is finished
 */
- (void)clearWithCacheType:(BU_SDImageCacheType)cacheType
                completion:(nullable SDWebImageNoParamsBlock)completionBlock;

@end
