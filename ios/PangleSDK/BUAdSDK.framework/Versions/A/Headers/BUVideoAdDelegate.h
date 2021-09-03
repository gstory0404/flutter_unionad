//
//  BUVideoAdDelegate.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/8/3.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BURewardedVideoAd.h"

/**
    用于插屏视频 激励视频 接口统一配置
 */
@protocol BUVideoAdDelegate <NSObject>

@property (nonatomic, assign) BOOL isRewardedVideo;

/**
 视频点击即将关闭
 */
- (void)videoAdWillClose;

/**
 视频点击关闭
 */
- (void)videoAdDidClose;

/**
 视频/落地页点击
 */
- (void)videoAdDidClick;

/**
 视频播放完成
 */
- (void)videoAdDidPlayFinishWithError:(NSError *)error;


@optional
@property (nonatomic, strong) BURewardedVideoModel *rewardedVideoModel;
/**
 视频点击跳过
 */
- (void)videoAdDidClickSkip;

/**
 服务器校验奖励成功发放.  2800进行了修改，包含了两种方式.
  1.C2C 不走服务端验证，直接根据时间发放奖励  2.S2S 老逻辑需要服务端验证
 */
- (void)videoAdServerRewardDidSucceedVerify:(BOOL)verify;

/**
 服务器校验奖励接口请求失败
 */
- (void)videoAdServerRewardDidFailWithError:(NSError *)error;

@end
