//
//  LCDWebImageDataCache.h
//  LCDSamples
//
//  Created by yuxr on 2021/7/8.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUWebImageDataCacheManager : NSObject

+ (instancetype)sharedManager;
- (NSData *)imageDataForKey:(NSString *)key;
- (void)storeImageData:(NSData *)imageData forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
