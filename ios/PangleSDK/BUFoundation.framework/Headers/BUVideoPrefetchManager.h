//
//  BUVideoPrefetchManager.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUPlayerSettingsProtocol.h"

typedef void (^prefetchVideoCancelBlock)(NSInteger preloadSize);

@interface BUVideoPrefetchManager : NSObject<BUPlayerSettingsProtocol>

+ (instancetype)sharedInstance;

/// 预加载视频
/// @param videoUrl 视频 URL
/// @param storgeName 视频文件存储名称
/// @param prefetchSize 预加载大小
/// @param prefetchStartBlock 预加载开始回调
/// @param prefetchFinshBlock 预加载结束回调
- (void)prefetchWithVideoUrl:(NSURL *)videoUrl
                  storgeName:(NSString *)storgeName
               prefetchSize:(NSUInteger)prefetchSize
          prefetchStartBlock:(void(^)(void))prefetchStartBlock
          prefetchFinshBlock:(void(^)(BOOL, NSInteger, NSError *, NSString *))prefetchFinshBlock
         prefetchCancelBlock:(prefetchVideoCancelBlock)prefetchCancelBlock;

/// 判断url是否正在下载
/// @param videoURL 视频 URL
- (BOOL)prefetchUrlInQueue:(NSURL *)videoURL;

/// 取消预加载，播放时应先取消预加载。
/// @param videoURL 视频 URL
- (void)cancelPrefetch:(NSURL *)videoURL;


/// 查询视频预加载大小
/// @param videoUrl 视频 URL
- (NSInteger)queryPrefetchSizeWithVideoUrl:(NSURL *)videoUrl;

@end
