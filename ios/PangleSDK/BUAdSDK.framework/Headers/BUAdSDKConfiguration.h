//
//  BUAdSDKConfiguration.h
//  BUAdSDK
//
//  Created by Eason on 2021/3/4.
//

#import <Foundation/Foundation.h>
#import "BUAdSDKDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUAdSDKConfiguration : NSObject

+ (instancetype)configuration;

/// This property should be set when integrating non-China and china areas at the same time,
/// otherwise it need'nt to be set.you‘d better set Territory first,  if you need to set them
@property (nonatomic, assign) BUAdSDKTerritory territory;

///Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
/// the unique identifier of the App
@property (nonatomic, copy) NSString *appID;

/// Configure development mode. default BUAdSDKLogLevelNone
@property (nonatomic, assign) BUAdSDKLogLevel logLevel;

/// the COPPA of the user, COPPA is the short of Children's Online Privacy Protection Rule,
/// the interface only works in the United States.
/// Coppa 0 adult, 1 child
/// You can change its value at any time
@property (nonatomic, strong) NSNumber *coppa;

/// additional user information.
@property (nonatomic, copy) NSString *userExtData;

/// Solve the problem when your WKWebview post message empty,
/// default is BUOfflineTypeWebview
@property (nonatomic, assign) BUOfflineType webViewOfflineType;

/// Custom set the GDPR of the user,GDPR is the short of General Data Protection Regulation,the interface only works in The European.
/// GDPR 0 close privacy protection, 1 open privacy protection
/// You can change its value at any time
@property (nonatomic, strong) NSNumber *GDPR;

/// Custom set the CCPA of the user,CCPA is the short of General Data Protection Regulation,the interface only works in USA.
/// CCPA  0: "sale" of personal information is permitted, 1: user has opted out of "sale" of personal information -1: default
@property (nonatomic, strong) NSNumber *CCPA;
/// Custom set the debugLog to print debug Log.
/// debugLog 0: close debug log, 1: open debug log.
@property (nonatomic, strong) NSNumber *debugLog;

@property (nonatomic, strong) NSNumber *themeStatus;

/// Custom set the AB vid of the user. Array element type is NSNumber
@property (nonatomic, strong) NSArray<NSNumber *> *abvids;

/// Custom set the tob ab sdk version of the user.
@property (atomic, copy) NSString *abSDKVersion;

/// Custom set idfa value
/// You can change its value at any time
@property (nonatomic, copy) NSString *customIdfa;

/**
 Whether to allow SDK to modify the category and options of AVAudioSession when playing audio, default is NO.
 The category set by the SDK is AVAudioSessionCategoryAmbient, and the options are AVAudioSessionCategoryOptionDuckOthers
 */
@property (atomic, assign) BOOL allowModifyAudioSessionSetting;

/**
 If you are a Unity developer, set this to Yes
 */
@property (nonatomic, assign) BOOL unityDeveloper;

@end

NS_ASSUME_NONNULL_END
