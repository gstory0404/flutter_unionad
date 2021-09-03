//
//  BUAdSmartlookManager.h
//  BUAdSDK
//
//  Created by wangchao on 2020/3/30.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUAdSmartlookManager : NSObject


+ (instancetype)sharedInstance;

+ (void)setupSmartlookConfig:(NSString *)config;
+ (void)resetConfig;

@end

NS_ASSUME_NONNULL_END
