//
//  BUVideoAdReportor.h
//  BUAdSDK
//
//  Created by bytedance on 2020/8/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// the reportor of video ad in feed, auto created by system if video ads in feed is customd.
@protocol BUVideoAdReportor <NSObject>

@required

/// report  start play video
- (void)startPlayVideo;

/// report did start play video
/// @param duration total duration of video, unit ms
- (void)didStartPlayVideoWithVideoDuration:(NSTimeInterval)duration;

/// report did start play video auto, designed by developer
/// @param duration total duration of video, unit ms
- (void)didAutoStartPlayWithVideoDuration:(NSTimeInterval)duration;

/// report did play to the end of video
- (void)didFinishVideo;

/// report did pause video
/// @param duration duration of video that user watched
- (void)didPauseVideoWithCurrentDuration:(NSTimeInterval)duration;

/// report did resume video from paused
/// @param duration duration of video that user watched
- (void)didResumeVideoWithCurrentDuration:(NSTimeInterval)duration;

/// report did break video playing, maybe change another video or disappear from screen and so on
/// @param duration duration of video that user watched
- (void)didBreakVideoWithCurrentDuration:(NSTimeInterval)duration;

/// report did click video view, auto implement by Pangle, developers need not call this method
/// @param duration duration of video that user watched
- (void)didClickVideoViewWithCurrentDuration:(NSTimeInterval)duration;

/// report sth. wrong with playing
/// @param error error
- (void)didPlayFailedWithError:(NSError *)error;

/// report sth. wrong with play start
/// @param error error
- (void)didPlayStartFailedWithError:(NSError *)error;

/// reprot did buffering video
- (void)didPlayBufferStart;

/// reprot did buffering video ended
- (void)didPlayBufferEnd;

@end

NS_ASSUME_NONNULL_END
