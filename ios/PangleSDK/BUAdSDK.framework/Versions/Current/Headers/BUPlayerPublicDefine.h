//
//  BUPlayerPublicDefine.h
//  BUAdSDK
//
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef BUPlayerPublicDefine_h
#define BUPlayerPublicDefine_h

typedef NS_ENUM(NSInteger, BUPlayerPlayState) {
    BUPlayerStateFailed    = 0,
    BUPlayerStateBuffering = 1,
    BUPlayerStatePlaying   = 2,
    BUPlayerStateStopped   = 3,
    BUPlayerStatePause     = 4,
    BUPlayerStateDefalt    = 5
};

#endif /* BUPlayerPublicDefine_h */
