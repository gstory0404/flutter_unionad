//
//  BUNativeExpressInterstitialAd.h
//  BUAdSDK
//
//  Created by xxx on 2019/5/16.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"
#import "BUMopubAdMarkUpDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class BUSize;
@class BUNativeExpressInterstitialAd;

@protocol BUNativeExpresInterstitialAdDelegate <NSObject>

@optional
/**
 This method is called when interstitial ad material loaded successfully.
 */
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad material failed to load.
 @param error : the reason of error
 */
- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError * __nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError * __nullable)error;

/**
 This method is called when interstitial ad slot will be showing.
 */
- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad is clicked.
 */
- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad is about to close.
 */
- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when interstitial ad is closed.
 */
- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType;

@end

/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUNativeExpressInterstitialAd : NSObject <BUMopubAdMarkUpDelegate>

@property (nonatomic, weak, nullable) id<BUNativeExpresInterstitialAdDelegate> delegate;

@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/**
 Initializes interstitial ad.
 @param slotID : The unique identifier of interstitial ad.
 @param adsize : custom size of ad view.
 @return BUNativeExpressInterstitialAd
 */
- (instancetype)initWithSlotID:(NSString *)slotID adSize:(CGSize)adsize;

/**
 Initializes express intersitial ad.
 @param slot A object, through which you can pass in the interstitial unique identifier, ad type, and so on
 @param adsize Customize the size of the view. Please make sure that the width and height passed in are available.
 @return BUNativeExpressInterstitialAd
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot adSize:(CGSize)adsize;

/**
 Load interstitial ad datas.
 */
- (void)loadAdData;

/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

/**
 Ad slot material id 
 */
- (NSString *)getAdCreativeToken;

@end

NS_ASSUME_NONNULL_END
