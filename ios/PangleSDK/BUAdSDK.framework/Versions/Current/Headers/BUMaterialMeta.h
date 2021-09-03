//
//  BUMaterialMeta.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUDislikeWords.h"
#import "BUImage.h"
#import "BUPersonalizationPrompts.h"

typedef NS_ENUM(NSInteger, BUInteractionType) {
    BUInteractionTypeCustorm = 0,
    BUInteractionTypeNO_INTERACTION = 1,  // pure ad display
    BUInteractionTypeURL = 2,             // open the webpage using a browser
    BUInteractionTypePage = 3,            // open the webpage within the app
    BUInteractionTypeDownload = 4,        // download the app
    BUInteractionTypePhone = 5,           // make a call
    BUInteractionTypeMessage = 6,         // send messages
    BUInteractionTypeEmail = 7,           // send email
    BUInteractionTypeVideoAdDetail = 8    // video ad details page
};

typedef NS_ENUM(NSInteger, BUFeedADMode) {
    BUFeedADModeSmallImage = 2,
    BUFeedADModeLargeImage = 3,
    BUFeedADModeGroupImage = 4,
    BUFeedVideoAdModeImage = 5, // video ad || rewarded video ad horizontal screen
    BUFeedVideoAdModePortrait = 15, // rewarded video ad vertical screen
    BUFeedADModeImagePortrait = 16,
    BUFeedADModeSquareImage   = 33, //SquareImage Currently it exists only in the oversea now. V3200 add
    BUFeedADModeSquareVideo   = 50, //SquareVideo Currently it exists only in the oversea now. V3200 add
    BUFeedADModeUnionSplashVideo = 154, // Video splash, V3800 add
};

@interface BUMaterialMeta : NSObject <NSCoding>

/// interaction types supported by ads.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign) BUInteractionType interactionType;

/// material pictures.
@property (nonatomic, strong) NSArray<BUImage *> *imageAry;

/// ad logo icon.
@property (nonatomic, strong) BUImage *icon;

/// ad headline.
@property (nonatomic, copy) NSString *AdTitle;

/// ad description.
@property (nonatomic, copy) NSString *AdDescription;

/// ad source.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, copy) NSString *source;

/// text displayed on the creative button.
@property (nonatomic, copy) NSString *buttonText;

/// display format of the in-feed ad, other ads ignores it.
@property (nonatomic, assign) BUFeedADMode imageMode;

/// Star rating, range from 1 to 5.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign) NSInteger score;

/// Number of comments.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign) NSInteger commentNum;

/// ad installation package size, unit byte.
@property (nonatomic, assign) NSInteger appSize;

/// video duration
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, assign) NSInteger videoDuration;

/// video url, will be empty string if allowCustomVideoPlayer is NO, contact BD to add to allow list.
@property (nonatomic, copy, readonly) NSString *videoUrl;

/// be allowed to play video ad via custome player, contact BD to add to allow list.
@property (nonatomic, assign, readonly) BOOL allowCustomVideoPlayer;

/// video resolution width
@property (nonatomic, assign, readonly) NSInteger videoResolutionWidth;

/// video resolution height
@property (nonatomic, assign, readonly) NSInteger videoResolutionHeight;

/// the reason why dislike the ad.
@property (nonatomic, copy) NSArray<BUDislikeWords *> *filterWords;

/// compliance statement of personalized advertising push
@property (nonatomic, strong) BUPersonalizationPrompts *personalPrompts;

/// media configuration parameters.
/// Please note: This API does not take effect on Pangle global, only use it when you have traffic from mainland China.
@property (nonatomic, copy) NSDictionary *mediaExt;

/// adx name, if it exists, it is recommended to display this text
@property (nonatomic, copy) NSString *ADXName;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError * __autoreleasing *)error;

@end

