//
//  BUPlayerInternalDefine.h
//  BUFoundation
//
//  Created by bytedance on 2020/12/17.
//

#ifndef BUPlayerInternalDefine_h
#define BUPlayerInternalDefine_h

typedef NS_ENUM(NSInteger, BUVideoPlayerState) {
    BUVideoPlayerStateFailed    = 0,
    BUVideoPlayerStateBuffering = 1,
    BUVideoPlayerStatePlaying   = 2,
    BUVideoPlayerStateStopped   = 3,
    BUVideoPlayerStatePause     = 4,
    BUVideoPlayerStateDefault    = 5
};

typedef NS_ENUM(NSUInteger, BUVideoPlayerDecoeMode) {
    BUVideoPlayerDecoeMode_H265_Local = 0,
    BUVideoPlayerDecoeMode_H265_Cache = 1,
    BUVideoPlayerDecoeMode_H265_Remote = 2,
    
    BUVideoPlayerDecoeMode_H264_Local = 3,
    BUVideoPlayerDecoeMode_H264_Cache = 4,
    BUVideoPlayerDecoeMode_H264_Remote = 5,
    BUVideoPlayerDecoeMode_Last = 5,
};

@class BUPlayer;

@protocol BUVideoPlayerDelegate <NSObject>

@optional
/**
 This method is called when the player status changes.
 */
- (void)player:(BUPlayer *)player stateDidChanged:(BUVideoPlayerState)playerState;


/// 播放器播放模式改变，当播放失败时会逐级降级
/// @param player 播放器播放模式改变
/// @param democeMode 播放模式
- (void)player:(BUPlayer *)player decodeModeChanged:(BUVideoPlayerDecoeMode)democeMode;

/**
 This method is called when the player is ready.
 */
- (void)playerReadyToPlay:(BUPlayer *)player;

/**
 This method is called when the player is ready, while application in background.
 */
- (void)playerReadyToPlayWhenApplicationEnterBackground:(BUPlayer *)player;

/**
 This method is called when the player plays completion or occurrs error.
 */
- (void)playerDidPlayFinish:(BUPlayer *)player error:(NSError *)error;

/**
 This method is called when the player is clicked.
 */
- (void)player:(BUPlayer *)player recognizeTapGesture:(UITapGestureRecognizer *)gesture;


/**
 This method is called when the view is clicked during ad play.
 */
- (void)playerTouchesBegan:(BUPlayer *)player;

@end


#endif /* BUPlayerInternalDefine_h */
