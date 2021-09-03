//
//  BUDislikeReportor.h
//  BUAdSDK
//
//  Created by bytedance on 2020/12/14.
//  Copyright © 2020 bytedance. All rights reserved.
//

#ifndef BUDislikeReportor_h
#define BUDislikeReportor_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BUDislikeWords;
@class BUPersonalizationPrompts;
/// the reportor for custom dislike
@protocol BUDislikeReportorDelegate <NSObject>
@optional
/// report selected dislike word
/// @param dislikeWords dislike words
- (void)dislikeDidSelected:(NSArray<BUDislikeWords *> *)dislikeWords;

/// report submit feedback string
/// @param feedback feedback string
- (void)dislikeDidSubmitFeedback:(NSString *)feedback;

/// reportor when personalization prompts's name did show
/// @param prompts personalization Ads prompts
- (void)dislikeDidShowPersonalizationPrompts:(BUPersonalizationPrompts *)prompts;

/// reportor when personalization prompts did selected
/// @param prompts personalization Ads prompts
- (void)dislikeDidSelectedPersonalizationPrompts:(BUPersonalizationPrompts *)prompts;

/// reportor when personalization prompts's url did load
/// @param prompts personalization prompts
- (void)dislikeDidLoadPersonalizationPromptsURL:(BUPersonalizationPrompts *)prompts;
@end

@class BUNativeAd;
/// Dislike Data Reportor for Native Ad
@interface BUDislikeReportor : NSObject <BUDislikeReportorDelegate>

/// Dislike Reportor Instance
/// @param nativeAd native Ad
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;
@end

#endif /* BUDislikeReportor_h */
