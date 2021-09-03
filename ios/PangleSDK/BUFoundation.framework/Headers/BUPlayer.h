//
//  BUPlayer.h
//  BUAdSDK
//
//  Created by hlw on 2017/12/21.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUPlayerDefine.h"
#import "BUPlayerInternalDefine.h"
#import "BUPlayerSettingsProtocol.h"

@class BUPlayerItem;
@interface BUPlayer : NSObject<BUPlayerSettingsProtocol>

@property (nonatomic, weak) id<BUVideoPlayerDelegate> delegate;

/**
 * 播放内容视图
 */
@property (nonatomic, strong, readonly) UIView *view;

/**
 * 播放器状态
 * 支持KVO
 */
@property (nonatomic, assign, readonly) BUVideoPlayerState state;

/// 播放器播放模式改变
@property (nonatomic, assign, readonly) BUVideoPlayerDecoeMode decodeMode;

/**
 * 播放资源总时长
 */
@property (nonatomic, assign, readonly) NSTimeInterval duration;

/**
 * 当前可播放时长
 */
@property (nonatomic, assign, readonly) NSTimeInterval playableDuration;

/**
 * 实际观看时长
 */
@property (nonatomic, assign, readonly) NSTimeInterval watchedDuration;

/**
 * 当前播放时间
 */
@property (nonatomic, assign, readonly) CGFloat currentPlayTime;


/// 当前播放链接
@property (nonatomic, strong, readonly) NSURL *currentPlayURL;

/**
 * 当前播放资源Item
 */
@property (nonatomic, strong, readonly) BUPlayerItem *currentPlayerItem;

/**
 * 播放器控制层容器,默认视图支持部分定制或完全自定义
 * 默认显示控制层全部元素,可以定制部分视图元素显示/隐藏
 * 若完全自定义,需先隐藏全部默认视图元素 再在容器上添加自定义视图
 */
@property (nonatomic, strong, readonly) UIView<BUPlayerControlViewProtocol> *controlContainer;

/**
 * 播放内容视图填充方式
 * 默认：等比例填充，直到一个维度到达区域边界
 */
@property (nonatomic, assign) BUPlayerLayerGravity playerLayerGravity;

/**
 * 播放视图上手势操作选项开关
 * 默认全开
 */
@property (nonatomic, assign) BUPlayerGestureOption option;

/**
 * 静音设置
 */
@property (nonatomic, assign) BOOL mute;

/**
 * 当前是否全屏显示
 */
@property (nonatomic, assign, readonly) BOOL isFullScreen;

/** 设置自定义ControlView */
@property (nonatomic, strong) UIView *controlView;

/**
 * 支持自动转屏,默认NO
 */
@property (nonatomic, assign) BOOL shouldAutoRotate;

/**
* jsb changeVideoState 暂停视频后,视频过一秒会继续开始播放.因为 timer 会调用 checkToPlayOrPause.
* 所以用属性进行标记
* 影响范围: 模板/非模板 的激励全屏视频
*/
@property (nonatomic, assign) BOOL isJSBPauseVideo;

+ (instancetype)playerWithPlayerItem:(BUPlayerItem *)item;

- (void)replaceCurrentItemWithPlayerItem:(BUPlayerItem *)item;


- (void)insertGaosiMohuWithLayer:(CALayer *)layer;

- (void)insertGaosiMohuWithView:(UIView *)view;

@end

@interface BUPlayer (BUPlayerControl)

/**
 * 播放
 */
- (void)play;

/**
 * 暂停
 */
- (void)pause;

/**
 * 重播
 */
- (void)replay;

/**
 * 停止
 */
- (void)stop;

/**
 * 跳到指定时间播放
 */
- (void)seekToTime:(NSTimeInterval)time completion:(void(^)(BOOL success))completion;

/**
 * 全屏/竖屏 切换显示
 */
- (void)changeOrientationScreen;


/**
 * 处于后台模式
 */
- (BOOL)isEnterBackground;

@end

@interface BUPlayer (BUTrack)
@property (nonatomic, strong) NSString *startTimestamp;
@property (nonatomic, strong) NSString *endTimestamp;
@end
