//
//  BUAdSlot.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUSize.h"
#import "BUAdSDKDefines.h"

typedef NS_ENUM(NSInteger, BUAdSlotAdType) {
    BUAdSlotAdTypeUnknown       = 0,
    BUAdSlotAdTypeBanner        = 1,       // banner ads
    BUAdSlotAdTypeInterstitial  = 2,       // interstitial ads
    BUAdSlotAdTypeSplash        = 3,       // splash ads
    BUAdSlotAdTypeSplash_Cache  = 4,       // cache splash ads
    BUAdSlotAdTypeFeed          = 5,       // feed ads
    BUAdSlotAdTypePaster        = 6,       // paster ads
    BUAdSlotAdTypeRewardVideo   = 7,       // rewarded video ads
    BUAdSlotAdTypeFullscreenVideo = 8,     // full-screen video ads
    BUAdSlotAdTypeDrawVideo     = 9,       // vertical (immersive) video ads
};

typedef NS_ENUM(NSInteger, BUAdSlotPosition) {
    BUAdSlotPositionTop = 1,
    BUAdSlotPositionBottom = 2,
    BUAdSlotPositionFeed = 3,
    BUAdSlotPositionMiddle = 4, // for interstitial ad only
    BUAdSlotPositionFullscreen = 5, 
};

/// value is equale req_type
typedef NS_ENUM(NSInteger, BUAdLoadType) {
    
    BUAdLoadTypeUnknown                    = -1,//Unknown
    BUAdLoadTypePreload                    = 1,//Preload resources
    BUAdLoadTypeLoad                       = 3,//Load resources in real time
};

typedef NS_ENUM(NSInteger, BUSplashButtonType) {
    BUSplashButtonType_FullScreen  = 1,  // The whole area of splash view will respond to click event
    BUSplashButtonType_DownloadBar = 2   // The area of download bar in splash view will respond to click event
};

@interface BUAdSlot : NSObject

/// required. The unique identifier of a native ad.
@property (nonatomic, copy) NSString *ID;

/// required. Ad type.
@property (nonatomic, assign) BUAdSlotAdType AdType;

/// optional. Ad display location. defaults is BUAdSlotPositionTop
@property (nonatomic, assign) BUAdSlotPosition position;

/// Accept a set of image sizes, please pass in the BUSize object.
@property (nonatomic, strong) NSMutableArray<BUSize *> *imgSizeArray;

/// required. Image size.
@property (nonatomic, strong) BUSize *imgSize;

/// Icon size.
@property (nonatomic, strong) BUSize *iconSize;

/// Maximum length of the title.
@property (nonatomic, assign) NSInteger titleLengthLimit;

/// Maximum length of description.
@property (nonatomic, assign) NSInteger descLengthLimit;

/// optional. Whether to support deeplink.defaults is true
@property (nonatomic, assign) BOOL isSupportDeepLink DEPRECATED_MSG_ATTRIBUTE("This property is deprecated,Settings are no longer required after version 3300");

/// Native banner ads and native interstitial ads are set to 1, other ad types are 0, the default is 0.
@property (nonatomic, assign) BOOL isOriginAd;

/// optional. Whether to support render control
@property (nonatomic, assign) BOOL supportRenderControl;

//adload_seq：（针对聚合广告位）传递本次请求是为“自然日内某设备某广告位置第N次展示机会”发出的广告请求，同物理位置在自然日从1开始计数，不同物理位置独立计数；example：某原生广告位置，当天第5次产生展示机会，这次展示机向穿山甲发送了4次广告请求，则这4次广告请求的"adload_seq"的值应为5。第二天重新开始计数。
@property (nonatomic, assign) NSInteger adloadSeq;

// Valid only in Native Banner and Native Interstitial
@property (nonatomic, assign) CGSize adSize;


//prime_rit：（针对聚合广告位）广告物理位置对应的固定穿山甲广告位id，可以使用第一层的广告位id也可以为某一层的广告位id，但要求同一物理位置在该字段固定上报同一广告位id，不频繁更换；example：某原生广告位，当天共发出了1000个请求，这1000个请求中使用了5个不同target的穿山甲rit，用某X rit来作为该位置的标记rit，则这1000次请求的prime_rit都需要上报X rit的rit id。
@property (nonatomic, copy) NSString *primeRit;

/// optional. AD id for preview
@property (nonatomic, copy) NSString *previewAdID;

/// optional. AD creative id for preview
@property (nonatomic, copy) NSString *previewCreativeID;

/// optional. extend msg
@property (nonatomic, copy) NSDictionary *ext;

/// optional. additional user information
@property (nonatomic, copy) NSString *userData;

/**
 Ad load type
    - BUAdLoadTypePreload : Preload resources
    - BUAdLoadTypeLoad:     Load resources in real time
 @Note :  This field is only useful in China. At present, this field is not necessary to set the content. It is only to investigate how developers use advertisements instead of realizing functions.
 */
@property (nonatomic, assign) BUAdLoadType adLoadType;

/// optional. config the behaviour of click splash view
@property (nonatomic, assign) BUSplashButtonType splashButtonType;

- (NSDictionary *)dictionaryValue;

@end

