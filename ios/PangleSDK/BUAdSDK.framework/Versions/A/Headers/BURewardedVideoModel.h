//
//  BURewardedVideoModel.h
//  BUAdSDK
//
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BURewardedVideoModel : NSObject

/**
   optional.
   Third-party game user_id identity.
   Mainly used in the reward issuance, it is the callback pass-through parameter from server-to-server.
   It is the unique identifier of each user.
   In the non-server callback mode, it will also be pass-through when the video is finished playing.
   Only the string can be passed in this case, not nil.
 */
@property (nonatomic, copy) NSString *userId;

//optional. serialized string.
@property (nonatomic, copy) NSString *extra;

//reward name. It will assigned value when the ads back.
@property (nonatomic, copy) NSString *rewardName;

//number of rewards. It will assigned value when the ads back.
@property (nonatomic, assign) NSInteger rewardAmount;

@end
