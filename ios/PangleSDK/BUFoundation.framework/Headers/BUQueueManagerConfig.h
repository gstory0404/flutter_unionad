//
//  BUQueueManagerConfig.h
//  BUFoundation
//
//  Created by Rush.D.Xzj on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUQueueManagerConfig : NSObject

@property (nonatomic, copy) NSString *queuePrefixLabel;

+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
