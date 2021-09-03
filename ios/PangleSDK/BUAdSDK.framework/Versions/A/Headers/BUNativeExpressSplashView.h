//
//  BUNativeExpressSplashView.h
//  BUAdSDK
//
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"
#import "BUMopubAdMarkUpDelegate.h"

@class BUNativeExpressSplashView;

NS_ASSUME_NONNULL_BEGIN
@protocol BUNativeExpressSplashViewDelegate <NSObject>
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)nativeExpressSplashViewDidLoad:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressSplashView:(BUNativeExpressSplashView *)splashAdView didFailWithError:(NSError * _Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpressSplashViewRenderSuccess:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressSplashViewRenderFail:(BUNativeExpressSplashView *)splashAdView error:(NSError * __nullable)error;

/**
 This method is called when nativeExpressSplashAdView will be showing.
 */
- (void)nativeExpressSplashViewWillVisible:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when nativeExpressSplashAdView is clicked.
 */
- (void)nativeExpressSplashViewDidClick:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when nativeExpressSplashAdView's skip button is clicked.
 */
- (void)nativeExpressSplashViewDidClickSkip:(BUNativeExpressSplashView *)splashAdView;
/**
 This method is called when nativeExpressSplashAdView countdown equals to zero
 */
- (void)nativeExpressSplashViewCountdownToZero:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when nativeExpressSplashAdView closed.
 */
- (void)nativeExpressSplashViewDidClose:(BUNativeExpressSplashView *)splashAdView;

/**
 This method is called when when video ad play completed or an error occurred.
 */
- (void)nativeExpressSplashViewFinishPlayDidPlayFinish:(BUNativeExpressSplashView *)splashView didFailWithError:(NSError *)error;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressSplashViewDidCloseOtherController:(BUNativeExpressSplashView *)splashView interactionType:(BUInteractionType)interactionType;

@end


/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUNativeExpressSplashView : UIView <BUMopubAdMarkUpDelegate>
/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<BUNativeExpressSplashViewDelegate> delegate;

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
 Whether the splash ad data has been loaded.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/**
 Initializes native express splash ad with slot id and frame.
 @param slotID : the unique identifier of splash ad
 @param adSize : the adSize of native express splashAd view. It is recommended for the mobile phone screen.
 @param rootViewController : the root controller for present splash.
 @return BUNativeExpressSplashView
 */
- (instancetype)initWithSlotID:(NSString *)slotID adSize:(CGSize)adSize rootViewController:(UIViewController *)rootViewController;

/**
 Initializes Express Splash video ad with ad slot, adSize and rootViewController.
 @param slot A object, through which you can pass in the splash unique identifier, ad type, and so on.
 @param adSize the adSize of native express splashAd view. It is recommended for the mobile phone screen.
 @param rootViewController the root controller for present splash.
 @return BUNativeExpressSplashView
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot adSize:(CGSize)adSize rootViewController:(UIViewController *)rootViewController;


/**
 Load splash ad datas.
 Start the countdown(@tolerateTimeout) as soon as you request datas.
 */
- (void)loadAdData;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

/**
 Remove splash view.
 Stop the countdown as soon as you call this method.
 移除开屏视图
 一旦调用这个方法，倒计时将自动停止
 */
- (void)removeSplashView;

@end

NS_ASSUME_NONNULL_END
