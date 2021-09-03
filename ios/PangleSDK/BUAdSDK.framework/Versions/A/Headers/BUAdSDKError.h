//
//  BUAdSDKError.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain BUPangleErrorHost ;

typedef NS_ENUM(NSInteger, BUErrorCode) {
    BUErrorCodeTempError        = -6,       // native template is invalid
    BUErrorCodeTempAddationError= -5,       // native template addation is invalid
    BUErrorCodeOpenAPPStoreFail = -4,       // failed to open appstore
    BUErrorCodeNOAdError        = -3,       // parsed data has no ads
    BUErrorCodeNetError         = -2,       // network request failed
    BUErrorCodeParseError       = -1,       // parsing failed
    
    BUErrorCodeSDKInitConfigUnfinished      = -100,   // sdk init config is unfinished

    BUErrorCodePlayableError_ERR_HAS_CACHE  = -702,   // has cache
    BUErrorCodePlayableError_ERR_UNZIP      = -704,   // unzip error

    BUErrorCodeNERenderResultError= 101,    // native Express ad, render result parse fail
    BUErrorCodeNETempError        = 102,    // native Express ad, template is invalid
    BUErrorCodeNETempPluginError  = 103,    // native Express ad, template plugin is invalid
    BUErrorCodeNEDataError        = 104,    // native Express ad, data is invalid
    BUErrorCodeNEParseError       = 105,    // native Express ad, parse fail
    BUErrorCodeNERenderError      = 106,    // native Express ad, render fail
    BUErrorCodeNERenderTimoutError= 107,    // native Express ad, render timeout
    BUErrorCodeTempLoadError      = 109,    // native Express ad, template load fail
    
    
    BUErrorCodeDynamic_1_JSContextEmpty     =       112,
    BUErrorCodeDynamic_1_ParseError         =       113,
    BUErrorCodeDynamic_1_Timeout            =       117,
    BUErrorCodeDynamic_1_SubComponentNotExist   =   118,
    
    BUErrorCodeDynamic_2_ParseError         =       123,
    BUErrorCodeDynamic_2_Timeout            =       127,
    BUErrorCodeDynamic_2_SubComponentNotExist   =   128,
    
    
    BUErrorCodeDRRenderEngineError = 401,   // native Express ad, engine error
    BUErrorCodeDRRenderContextError = 402,  // native Express ad, context error
    BUErrorCodeDRRenderItemNotExist = 403,  // native Express ad, item not exist
    
    BUErrorCodeSDKStop          = 1000,     // SDK stop forcely
    
    BUErrorCodeParamError       = 10001,    // parameter error
    BUErrorCodeTimeout          = 10002,

    BUErrorCodeSuccess          = 20000,
    BUErrorCodeNOAD             = 20001,    // no ads
    
    BUErrorCodeContentType      = 40000,    // http conent_type error
    BUErrorCodeRequestPBError   = 40001,    // http request pb error
    BUErrorCodeAppEmpty         = 40002,    // request app can't be empty
    BUErrorCodeWapEMpty         = 40003,    // request wap can't be empty
    BUErrorCodeAdSlotEmpty      = 40004,    // missing ad slot description
    BUErrorCodeAdSlotSizeEmpty  = 40005,    // the ad slot size is invalid
    BUErrorCodeAdSlotIDError    = 40006,    // the ad slot ID is invalid
    BUErrorCodeAdCountError     = 40007,    // request the wrong number of ads
    BUUnionAdImageSizeError     = 40008,    // wrong image size
    BUUnionAdSiteIdError        = 40009,    // Media ID is illegal
    BUUnionAdSiteMeiaTypeError  = 40010,    // Media type is illegal
    BUUnionAdSiteAdTypeError    = 40011,    // Ad type is illegal
    BUUnionAdSiteAccessMethodError  = 40012,// Media access type is illegal and has been deprecated
    BUUnionSplashAdTypeError    = 40013,    // Code bit id is less than 900 million, but adType is not splash ad
    BUUnionRedirectError        = 40014,    // The redirect parameter is incorrect
    BUUnionRequestInvalidError  = 40015,    // Media rectification exceeds deadline, request illegal
    BUUnionAppSiteRelError      = 40016,    // The relationship between slot_id and app_id is invalid.
    BUUnionAccessMethodError    = 40017,    // Media access type is not legal API/SDK
    BUUnionPackageNameError     = 40018,    // Media package name is inconsistent with entry
    BUUnionConfigurationError   = 40019,    // Media configuration ad type is inconsistent with request
    BUUnionRequestLimitError    = 40020,    // The ad space registered by developers exceeds daily request limit
    BUUnionSignatureError       = 40021,    // Apk signature sha1 value is inconsistent with media platform entry
    BUUnionIncompleteError      = 40022,    // Whether the media request material is inconsistent with the media platform entry
    BUUnionOSError              = 40023,    // The OS field is incorrectly filled
    BUUnionLowVersion           = 40024,    // The SDK version is too low to return ads
    BUErrorCodeAdPackageIncomplete  = 40025,// the SDK package is incomplete. It is recommended to verify the integrity of SDK package or contact technical support.
    BUUnionMedialCheckError     = 40026,    // Non-international account request for overseas delivery system
    BUUnionSlotIDRenderMthodNoMatch = 40029,// The rendering method for slot ID does not match.
    
    
    BUUnionCpidChannelCodeError = 40030, // Huawei browse impex cpid channeld code does not match.
    BUUnionInternationalRequestCurrencyTypeError = 40031, // International request currency type is empty.
    BUUnionOpenRTBRequestTokenError    =40032, // OpenRTB request token is empty.
    BUUnionHardCodeError   =   40033, // Hard code not return ads, return message does not adjust.
    
    
    BUUnionSDKVersionTooLow   =40041, // SDK version is too low.
    BUUnionNewInterstitialStyleVersionError  =    40042, // New interstitial style use sdk version is too low. Plese upgrade SDK version to 3.5.5.0.
    BUUnionPreviewFlowInvalid   =40043, // Preview flow invalid.
    
    BUErrorCodeSysError         = 50001,     // ad server error
    
    
    BUErrorCodeNetworkError =   98764,  // network error.
    BUErrorCodeUndefined    =       98765, // error undefined
};
