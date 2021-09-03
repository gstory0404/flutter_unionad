//
//  BUCacheManager.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/9/19.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *BUCacheConfigurationKey;
extern NSString *BUCacheFinishedErrorKey;

@class BUCacheConfiguration;
@interface BUCacheManager : NSObject

+ (instancetype)shared;

// 设置缓存目录
+ (void)setCacheDirectory:(NSString *)cacheDirectory;

// 获取缓存目录
+ (NSString *)cacheDirectory;

/// 获取视频本地缓存
/// @param url 服务端视频地址
+ (NSString *)cachedFilePathForURL:(NSURL *)url;

/// 获取视频配置文件
/// @param url 服务端视频地址
+ (BUCacheConfiguration *)cacheConfigurationForURL:(NSURL *)url;

/// 删除本地超出缓存大小的缓存文件
/// 当该文件正在缓存、或正在被播放器占用时不会被删除
/// 内部使用异步线程删除，线程非阻塞
- (void)clearOverSizeCache;

- (void)cacheResourceUseBegin:(NSURL *)url;

- (void)cacheResourceUseEnd:(NSURL *)url;

- (void)clearSpecifiedResource:(NSURL *)url;

@end
