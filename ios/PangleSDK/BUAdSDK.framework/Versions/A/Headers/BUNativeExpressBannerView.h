//
//  BUNativeExpressBannerView.h
//  BUAdSDK
//
//  Created by xxx on 2019/5/17.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"
#import "BUMopubAdMarkUpDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class BUNativeExpressBannerView;
@class BUDislikeWords;
@class BUSize;

@protocol BUNativeExpressBannerViewDelegate <NSObject>

@optional
/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when bannerAdView ad slot failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error;

/**
 This method is called when bannerAdView ad slot showed new ad.
 */
- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when bannerAdView is clicked.
 */
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView;

/**
 This method is called when the user clicked dislike button and chose dislike reasons.
 @param filterwords : the array of reasons for dislike.
 */
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType;

/**
 This method is called when the Ad view container is forced to be removed.
 @param bannerAdView : Express Banner Ad view container
 */
- (void)nativeExpressBannerAdViewDidRemoved:(BUNativeExpressBannerView *)bannerAdView;
@end

@interface BUNativeExpressBannerView : UIView <BUMopubAdMarkUpDelegate>

@property (nonatomic, weak, nullable) id<BUNativeExpressBannerViewDelegate> delegate;

/**
 The carousel interval, in seconds, is set in the range of 30~120s, and is passed during initialization. If it does not meet the requirements, it will not be in carousel ad.
 */
@property (nonatomic, assign, readonly) NSInteger interval;

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

/**
 Initializes express banner ad.
 @param slotID The unique identifier of banner ad.
 @param rootViewController The root controller where the banner is located.
 @param adsize Customize the size of the view. Please make sure that the width and height passed in are available.
 @return BUNativeExpressBannerView
 */
- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(CGSize)adsize;

/**
 Initializes carousel express banner ad.
 @param slotID The unique identifier of banner ad.
 @param rootViewController The root controller where the banner is located.
 @param adsize Customize the size of the view. Please make sure that the width and height passed in are available.
 @param interval The carousel interval, in seconds, is set in the range of 30~120s, and is passed during initialization. If it does not meet the requirements, it will not be in carousel ad.
 @return BUNativeExpressBannerView
 */
- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(CGSize)adsize
                      interval:(NSInteger)interval;

/**
 Initializes express banner ad.
 @param slot A object, through which you can pass in the banner unique identifier, ad type, and so on
 @param rootViewController The root controller where the banner is located.
 @param adsize Customize the size of the view. Please make sure that the width and height passed in are available.
 @return BUNativeExpressBannerView
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot
            rootViewController:(UIViewController *)rootViewController
                      adSize:(CGSize)adsize;

/**
 Initializes carousel express banner ad.
 @param slot A object, through which you can pass in the banner unique identifier, ad type, and so on
 @param rootViewController The root controller where the banner is located.
 @param adsize Customize the size of the view. Please make sure that the width and height passed in are available.
 @param interval The carousel interval, in seconds, is set in the range of 30~120s, and is passed during initialization. If it does not meet the requirements, it will not be in carousel ad.
 @return BUNativeExpressBannerView
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot
            rootViewController:(UIViewController *)rootViewController
                        adSize:(CGSize)adsize
                      interval:(NSInteger)interval;

- (void)loadAdData;

/**
 Ad slot material id
 */
- (NSString *)getAdCreativeToken;

@end

@interface BUNativeExpressBannerView (Deprecated)
- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(CGSize)adsize
             IsSupportDeepLink:(BOOL)isSupportDeepLink DEPRECATED_MSG_ATTRIBUTE("Use initWithSlotID:rootViewController:adSize: instead.");
- (instancetype)initWithSlotID:(NSString *)slotID
            rootViewController:(UIViewController *)rootViewController
                        adSize:(CGSize)adsize
             IsSupportDeepLink:(BOOL)isSupportDeepLink
                      interval:(NSInteger)interval DEPRECATED_MSG_ATTRIBUTE("Use initWithSlotID:rootViewController:adSize:interval: instead.");
@end

NS_ASSUME_NONNULL_END
