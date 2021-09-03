//
//  BUPlayerItem.h
//  BUAdSDK
//
//  Created by hlw on 2017/12/21.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUPlayerItem : NSObject

/// 视频标题
@property (nonatomic, copy) NSString *title;

/// 视频URL - H.264 - 远程
@property (nonatomic, strong) NSURL *videoURL_H264_Remote;

/// 视频URL - H.264 - 本地 兼容方案，激励视频由上层控制
@property (nonatomic, strong) NSURL *videoURL_H264_Local;

/// 视频URL - HEVC - 远程
@property (nonatomic, strong) NSURL *videoURL_H265_Remote;

/// 视频URL - HEVC - 本地
@property (nonatomic, strong) NSURL *videoURL_H265_Local;

/// 允许使用 H265 进行播放
@property (nonatomic, assign) BOOL enableH265;

/// H265 下允许降级播放
@property (nonatomic, assign) BOOL enableH265DowngradePlay;

/// H264 下允许降级播放
@property (nonatomic, assign) BOOL enableH264DowngradePlay;

/// 允许使用边下边播
@property (nonatomic, assign) BOOL enableCache;

/// 视频封面网络图片url
@property (nonatomic, copy) NSString *placeholderImageURLString;

///  默认图的展示形式
@property (nonatomic, assign) UIViewContentMode placeholderImageContentMode;

/// 从xx秒开始播放视频(默认0)
@property (nonatomic, assign) NSInteger seekTime;

@end

NS_ASSUME_NONNULL_END
