//
//  BUPlayerDefine.h
//  BUAdSDK
//
//  Created by carl on 2017/12/24.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * playerLayer的填充模式
 */
typedef NS_ENUM(NSInteger, BUPlayerLayerGravity) {
    BUPlayerLayerGravityResize,           // 非均匀模式。两个维度完全填充至整个视图区域
    BUPlayerLayerGravityResizeAspect,     // 等比例填充，直到一个维度到达区域边界
    BUPlayerLayerGravityResizeAspectFill  // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

/**
 * 手势交互操作
 */
typedef NS_OPTIONS(NSInteger, BUPlayerGestureOption) {
    BUPlayerGestureOptionNone              = 0,
    BUPlayerGestureOptionVolumeEnabled     = 1 << 0,
    BUPlayerGestureOptionBrightnessEnabled = 1 << 1,
    BUPlayerGestureOptionFastSkipEnabled   = 1 << 2,
    BUPlayerGestureOptionSigleTapEnabled   = 1 << 3,
    BUPlayerGestureOptionDoubleTapEnabled  = 1 << 4,
};
/**
 * 默认的控制视图或完成视图的元素
 */
typedef NS_OPTIONS(NSInteger, BUPlayerDefaultControlElement) {
    BUPlayerControlElementNone     = 0,
    BUPlayerControlElementTop      = 1 << 0,
    BUPlayerControlElementBottom   = 1 << 1,
    BUPlayerControlElementActivity = 1 << 2,
    BUPlayerControlElementFailHint = 1 << 3,
    BUPlayerControlElementProgress = 1 << 4,
    BUPlayerControlElementPlay     = 1 << 5,
    BUPlayerControlElementReplay   = 1 << 6,
};

typedef NSString * BUPlayerUIControlImage;
typedef NSString * BUPlayerUIControlLocalizedString;

#define BUPlayerUIControlImage_LeftBack       @"bu_leftback"
#define BUPlayerUIControlImage_TopShadow      @"bu_topShadow"
#define BUPlayerUIControlImage_BottomShadow   @"bu_bottomShadow"
#define BUPlayerUIControlImage_BottomPlay     @"bu_bottomPlay"
#define BUPlayerUIControlImage_BottomPause    @"bu_bottomPause"
#define BUPlayerUIControlImage_FullClose      @"bu_fullClose"
#define BUPlayerUIControlImage_SliderDot      @"bu_sliderDot"
#define BUPlayerUIControlImage_FullScreen     @"bu_fullScreen"
#define BUPlayerUIControlImage_ShrinkScreen   @"bu_shrinkScreen"
#define BUPlayerUIControlImage_Replay         @"bu_replay"
#define BUPlayerUIControlImage_Play           @"bu_play"
#define BUPlayerUIControlImage_Pause          @"bu_pause"
#define BUPlayerUIControlImage_FastForward    @"bu_fastForward"
#define BUPlayerUIControlImage_FastBackward   @"bu_fastBackward"

#define BUPlayerUIControlLocalizedString_Close @"bu_LoStr_Close"

@protocol BUPlayerControlViewProtocol <NSObject>

- (instancetype)initWithContrlResourceBundle:(NSBundle *)bundle
                                      images:(NSDictionary <BUPlayerUIControlImage, NSString *> *)images
                            localizedStrings:(NSDictionary <BUPlayerUIControlLocalizedString, NSString *>*)localizedStrings;

/**
 * 设置默认控制视图或完成视图的元素组合方式
 * 默认显示全部
 */
- (void)setPlayerDefaultControlElement:(BUPlayerDefaultControlElement)element;
/**
 * 获取播放完成视图容器
 * 若需自定义可先移除BUPlayerControlElementReplay,再添加自定义视图
 */
- (UIView *)finishedContainer;

@end
