//
//  TTGifImageView.h
//  Article
//
//  Created by carl on 2017/5/21.
//
//

#import <UIKit/UIKit.h>
#import "BUGifImage.h"

@protocol BUAnimationImageView
@property (nonatomic, assign) BOOL repeats;
@property (nonatomic, copy)   void (^completionHandler)(BOOL);
@property (nonatomic, strong, readonly) BUGifImage *gifImage;
@property (nonatomic, assign) NSInteger currentPlayIndex;
@property (nonatomic, assign) BOOL delayDuration;
@end

@interface BUGifImageView : UIImageView <BUAnimationImageView>
@property (nonatomic, assign) BOOL repeats;
@property (nonatomic, copy)   void (^completionHandler)(BOOL);
@property (nonatomic, strong, readonly) BUGifImage *gifImage;
@property (nonatomic, assign) NSInteger currentPlayIndex;
@property (nonatomic, assign) BOOL delayDuration; 
@end
