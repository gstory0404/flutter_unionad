//
//  BUSplashAdView.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"
#import "BUSplashZoomOutView.h"
#import "BUMopubAdMarkUpDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUSplashAdDelegate;

/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUSplashAdView : UIView <BUMopubAdMarkUpDelegate>
/**
The unique identifier of splash ad.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

/**
 Maximum allowable load timeout, default 3s, unit s.
 */
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;


/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 Whether the splash ad data has been loaded.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/// When it is a zoom out advertisement, it has value.
@property (nonatomic, strong, readonly) BUSplashZoomOutView *zoomOutView;

/**
 Initializes splash ad with slot id and frame.
 @param slotID : the unique identifier of splash ad
 @param frame : the frame of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashAdView
 */
- (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;

/**
 Initializes splash ad with ad slot and frame.
 @param slot A object, through which you can pass in the splash unique identifier、ad type, and so on
 @param frame the frame of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashAdView
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot frame:(CGRect)frame;

/**
 Load splash ad datas.
 Start the countdown(@tolerateTimeout) as soon as you request datas.
 */
- (void)loadAdData;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

@end


@protocol BUSplashAdDelegate <NSObject>

@optional
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError * _Nullable)error;

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(BUSplashAdView *)splashAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType;

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd;

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd;

@end

NS_ASSUME_NONNULL_END

