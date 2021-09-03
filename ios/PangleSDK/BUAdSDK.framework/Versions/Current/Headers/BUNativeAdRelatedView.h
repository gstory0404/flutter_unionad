//
//  BUNativeAdRelatedView.h
//  BUAdSDK
//
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUVideoAdView.h"
#import "BUNativeAd.h"
#import "BUVideoAdReportor.h"
#import "BUDislikeReportor.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUNativeAdRelatedView : NSObject

/**
 Need to actively add to the view in order to deal with the feedback and improve the accuracy of ad.
 */
@property (nonatomic, strong, readonly, nullable) UIButton *dislikeButton;

///Promotion label.Need to actively add to the view.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, strong, readonly, nullable) UILabel *adLabel;

///Ad logo.Need to actively add to the view.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, strong, readonly, nullable) UIImageView *logoImageView;
/**
 Ad logo + Promotion label.Need to actively add to the view.
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *logoADImageView;

/**
 Video ad view. Need to actively add to the view. Can not coexist with videoAdReportor.
 */
@property (nonatomic, strong, readonly, nullable) BUVideoAdView *videoAdView;

/**
Video ad Reportor. Can not coexist with videoAdView.
*/
@property (nonatomic, strong, readonly, nullable) id<BUVideoAdReportor> videoAdReportor;

/**
 Refresh the data every time you get new datas in order to show ad perfectly.
 */
- (void)refreshData:(BUNativeAd *)nativeAd;

//@property (nonatomic, copy) BOOL(^expectUseCustomVideoPlayer)(BOOL isSupported, NSString *videoUrl);

@end

NS_ASSUME_NONNULL_END
