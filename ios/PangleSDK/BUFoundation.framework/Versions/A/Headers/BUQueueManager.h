//
//  BUQueueManager.h
//  BUFoundation
//
//  Created by Rush.D.Xzj on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "BUQueueManagerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUQueueManager : NSObject

@property (nonatomic, strong, readonly) BUQueueManagerConfig *config;

- (void)updateConfig:(BUQueueManagerConfig *)config;

+ (NSString *)serialQueuePrefixLabel;
+ (NSString *)concurrentQueuePrefixLabel;

- (void)associateObject:(id)object withSerialQueue:(dispatch_queue_t)serialQueue;
- (void)associateObject:(id)object withConcurrentQueue:(dispatch_queue_t)concurrentQueue;

#pragma mark - Signal
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
