//
//  BULogManager.h
//  BUAdSDK
//
//  Created by bytedance on 2020/6/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

// 这里跟 BUAdSDKLogLevel 对齐
typedef NS_ENUM(NSInteger, BULogManagerLevel) {
    BULogManagerLevelNone,
    BULogManagerLevelError,
    BULogManagerLevelWarning,
    BULogManagerLevelInfo,
    BULogManagerLevelDebug,
    BULogManagerLevelVerbose,
};

typedef NS_ENUM(NSInteger, BULogServerControlMode) {
    BULogManagerServerControlCloseMode,
    BULogManagerServerControlDebugMode,
};

NS_ASSUME_NONNULL_BEGIN

@interface BULogManager : NSObject

@property (nonatomic, assign) BULogManagerLevel level;
@property (nonatomic, assign) BULogServerControlMode mode;

+ (void)errorLogWithFormat:(NSString *)format, ...;
+ (void)warningLogWithFormat:(NSString *)format, ...;
+ (void)infoLogWithFormat:(NSString *)format, ...;
+ (void)debugLogWithFormat:(NSString *)format, ...;
+ (void)verboseLogWithFormat:(NSString *)format, ...;
+ (void)internalLogWithFormat:(NSString *)format, ...;
+ (void)serverLogWithFormat:(NSString *)format, ...;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
