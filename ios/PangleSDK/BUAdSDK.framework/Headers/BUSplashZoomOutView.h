//
//  BUSplashZoomOutView.h
//  BUAdSDK
//
//  Created by wangyanlin on 2020/6/17.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUMaterialMeta.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUSplashZoomOutViewDelegate;

/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUSplashZoomOutView : UIView
/*
required.
Root view controller for handling ad actions.
*/
@property (nonatomic, weak) UIViewController *rootViewController;

/**
Suggested size for show.
*/
@property (nonatomic, assign, readonly) CGSize showSize;

/**
The delegate for receiving state change messages.
*/
@property (nonatomic, weak) id<BUSplashZoomOutViewDelegate> delegate;
@end

@protocol BUSplashZoomOutViewDelegate <NSObject>
/**
 This method is called when splash ad is clicked.
 */
- (void)splashZoomOutViewAdDidClick:(BUSplashZoomOutView *)splashAd;

/**
 This method is called when splash ad is closed.
 */
- (void)splashZoomOutViewAdDidClose:(BUSplashZoomOutView *)splashAd;

/**
This method is called when spalashAd automatically dimiss afte countdown equals to zero
*/
- (void)splashZoomOutViewAdDidAutoDimiss:(BUSplashZoomOutView *)splashAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashZoomOutViewAdDidCloseOtherController:(BUSplashZoomOutView *)splashAd interactionType:(BUInteractionType)interactionType;

@end
NS_ASSUME_NONNULL_END
