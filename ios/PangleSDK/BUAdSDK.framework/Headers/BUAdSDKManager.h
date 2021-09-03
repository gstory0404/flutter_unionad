//
//  BUAdSDKManager.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUAdSDKDefines.h"
#import "BUMopubAdMarkUpDelegate.h"

typedef NS_ENUM(NSInteger, BUAdSDKInitializationState) {
    BUAdSDKInitializationStateNotReady = 0,
    BUAdSDKInitializationStateReady = 1
};

typedef void (^BUConfirmGDPR)(BOOL isAgreed);

typedef void (^BUCompletionHandler)(BOOL success,NSError *error);

@interface BUAdSDKManager : NSObject

@property (nonatomic, copy, readonly, class) NSString *SDKVersion;

/// The PangleSDK initialization state
@property (nonatomic, assign, readonly, class) BUAdSDKInitializationState initializationState;

/// The synchronize initialization method of Pangle
/// @param completionHandler Callback to the initialization state of the calling thread
+ (void)startWithSyncCompletionHandler:(BUCompletionHandler)completionHandler;

/// The asynchronize initialization method of Pangle
/// @param completionHandler Callback to the initialization state of the non-main thread
+ (void)startWithAsyncCompletionHandler:(BUCompletionHandler)completionHandler;

/// Open GDPR Privacy for the user to choose before setAppID.
+ (void)openGDPRPrivacyFromRootViewController:(UIViewController *)rootViewController confirm:(BUConfirmGDPR)confirm;

@end


@interface BUAdSDKManager (MopubAdaptor) <BUMopubAdMarkUpDelegate>

@end

@interface BUAdSDKManager (BUAdNR)
+ (NSString *)bunr_dictionaryWithSlot:(BUAdSlot *)slot isDynamicRender:(BOOL)isDynamicRender;
@end


@interface BUAdSDKManager (InterfaceReadyReplacement)
/**
This property should be set when integrating non-China and china areas at the same time, otherwise it need'nt to be set.you‘d better set Territory first,  if you need to set them
@param territory : Regional value
*/
+ (void)setTerritory:(BUAdSDKTerritory)territory;
/**
 Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
 @param appID : the unique identifier of the App
 */
+ (void)setAppID:(NSString *)appID;
/**
 Configure development mode.
 @param level : default BUAdSDKLogLevelNone
 */
+ (void)setLoglevel:(BUAdSDKLogLevel)level;

/* Set the COPPA of the user, COPPA is the short of Children's Online Privacy Protection Rule, the interface only works in the United States.
 * @params Coppa 0 adult, 1 child
 */
+ (void)setCoppa:(NSUInteger)coppa;

/// Set the user's keywords, such as interests and hobbies, etc.
/// Must obtain the consent of the user before incoming.
+ (void)setUserKeywords:(NSString *)keywords;

/// set additional user information.
+ (void)setUserExtData:(NSString *)data;

/// Set whether the app is a paid app, the default is a non-paid app.
/// Must obtain the consent of the user before incoming
+ (void)setIsPaidApp:(BOOL)isPaidApp;

/// Solve the problem when your WKWebview post message empty,default is BUOfflineTypeWebview
+ (void)setOfflineType:(BUOfflineType)type;

/// Custom set the GDPR of the user,GDPR is the short of General Data Protection Regulation,the interface only works in The European.
/// @params GDPR 0 close privacy protection, 1 open privacy protection
+ (void)setGDPR:(NSInteger)GDPR;

/// Custom set the CCPA of the user,CCPA is the short of General Data Protection Regulation,the interface only works in USA.
/// @params CCPA  0: "sale" of personal information is permitted, 1: user has opted out of "sale" of personal information -1: default
+ (void)setCCPA:(NSInteger)CCPA;

/// Custom set the AB vid of the user. Array element type is NSNumber
+ (void)setABVidArray:(NSArray<NSNumber *> *)abvids;

/// Custom set the tob ab sdk version of the user.
+ (void)setABSDKVersion:(NSString *)abSDKVersion;


/// Custom set idfa value
+ (void)setCustomIDFA:(NSString *)idfa;



+ (void)setThemeStatus:(BUAdSDKThemeStatus)themeStatus;

/// get appID
+ (NSString *)appID;

/// get isPaidApp
+ (BOOL)isPaidApp;

/// get GDPR
+ (NSInteger)GDPR;

/// get coppa
+ (NSUInteger)coppa;

/// get CCPA
+ (NSInteger)CCPA;

/**
 Whether to allow SDK to modify the category and options of AVAudioSession when playing audio, default is NO.
 The category set by the SDK is AVAudioSessionCategoryAmbient, and the options are AVAudioSessionCategoryOptionDuckOthers
 */
+ (void)allowModifyAudioSessionSetting:(BOOL)isAllow;


+ (BUAdSDKThemeStatus)themeStatus;

@end

