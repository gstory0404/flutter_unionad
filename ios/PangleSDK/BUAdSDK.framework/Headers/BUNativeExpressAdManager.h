//
//  BUNativeExpressAdManager.h
//  BUAdSDK
//
//  Created by bytedance on 2019/1/20.
//  Copyright © 2019年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUAdSlot.h"
#import "BUMaterialMeta.h"
#import "BUNativeExpressAdView.h"
#import "BUDislikeWords.h"
#import "BUPlayerPublicDefine.h"
#import "BUMopubAdMarkUpDelegate.h"
#import "BUNativeExpressAdViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN


/// Please note: This Class does not take effect on Pangle global, only use it when you have traffic from mainland China.
@interface BUNativeExpressAdManager : NSObject <BUMopubAdMarkUpDelegate>

@property (nonatomic, strong, nullable) BUAdSlot *adslot;

@property (nonatomic, assign, readwrite) CGSize adSize;

/**
 The delegate for receiving state change messages from a BUNativeExpressAdManager
 */
@property (nonatomic, weak, nullable) id<BUNativeExpressAdViewDelegate> delegate;


/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */
- (instancetype)initWithSlot:(BUAdSlot * _Nullable)slot adSize:(CGSize)size;

/**
 The number of ads requested,The maximum is 3
 */
- (void)loadAdDataWithCount:(NSInteger)count;
@end

@interface BUNativeExpressAdManager (Deprecated)
- (void)loadAd:(NSInteger)count __attribute__((deprecated("Use loadAdDataWithCount: instead.")));
@end


NS_ASSUME_NONNULL_END
