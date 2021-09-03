/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "BU_SDWebImageCompat.h"
#import "BU_SDWebImageDefine.h"

@class BU_SDWebImageOptionsResult;

typedef BU_SDWebImageOptionsResult * _Nullable(^BU_SDWebImageOptionsProcessorBlock)(NSURL * _Nullable url, BU_SDWebImageOptions options, SDWebImageContext * _Nullable context);

/**
 The options result contains both options and context.
 */
@interface BU_SDWebImageOptionsResult : NSObject

/**
 BU_WebCache options.
 */
@property (nonatomic, assign, readonly) BU_SDWebImageOptions options;

/**
 Context options.
 */
@property (nonatomic, copy, readonly, nullable) SDWebImageContext *context;

/**
 Create a new options result.

 @param options options
 @param context context
 @return The options result contains both options and context.
 */
- (nonnull instancetype)initWithOptions:(BU_SDWebImageOptions)options context:(nullable SDWebImageContext *)context;

@end

/**
 This is the protocol for options processor.
 Options processor can be used, to control the final result for individual image request's `BU_SDWebImageOptions` and `SDWebImageContext`
 Implements the protocol to have a global control for each indivadual image request's option.
 */
@protocol BU_SDWebImageOptionsProcessor <NSObject>

/**
 Return the processed options result for specify image URL, with its options and context

 @param url The URL to the image
 @param options A mask to specify options to use for this request
 @param context A context contains different options to perform specify changes or processes, see `BU_SDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
 @return The processed result, contains both options and context
 */
- (nullable BU_SDWebImageOptionsResult *)processedResultForURL:(nullable NSURL *)url
                                                    options:(BU_SDWebImageOptions)options
                                                    context:(nullable SDWebImageContext *)context;

@end

/**
 A options processor class with block.
 */
@interface BU_SDWebImageOptionsProcessor : NSObject<BU_SDWebImageOptionsProcessor>

- (nonnull instancetype)initWithBlock:(nonnull BU_SDWebImageOptionsProcessorBlock)block;
+ (nonnull instancetype)optionsProcessorWithBlock:(nonnull BU_SDWebImageOptionsProcessorBlock)block;

@end
