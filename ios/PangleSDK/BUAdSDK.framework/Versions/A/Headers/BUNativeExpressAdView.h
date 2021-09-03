//
//  BUNativeExpressAdView.h
//  BUAdSDK
//
//  Created by bytedance on 2019/1/20.
//  Copyright © 2019年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface BUNativeExpressAdView : UIView
/**
 * Whether render is ready
 */
@property (nonatomic, assign, readonly) BOOL isReady;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/// video duration.
@property (nonatomic,assign, readonly) NSInteger videoDuration;

/// Get the already played time.
@property (nonatomic,assign, readonly) CGFloat currentPlayedTime;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 required
 */
- (void)render;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;


@end

NS_ASSUME_NONNULL_END
