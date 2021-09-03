//
//  BUGeckoManager.h
//  Pods
//
//  Created by admin on 2021/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^BUGeckoPreloadCompletion)(NSData * _Nullable data,NSDictionary * _Nullable respHeader);
typedef void (^BUGeckoSyncDataCompletion)(BOOL success,NSDictionary *info);

@interface BUGeckoManager : NSObject

// 判断gecko是否已经初始化
+ (BOOL)geckoDidSetup;

// 注册Gecko的Accesskey，不同的Accesskey可以区分不同的业务
+ (void)registAccessKey:(NSString *)ak;

// 同步Gecko资源
+ (void)syncResourcesParamsWithAccessKey:(NSString *)ak
                                channels:(NSArray<NSString *> *)channelIds
                                   hosts:(NSArray *)hosts
                              completion:(BUGeckoSyncDataCompletion _Nullable)completion;

+ (void)asyncGetDataWithInfo:(NSDictionary *)info
                   accessKey:(NSString *)ak
                     channel:(NSString *)channel
                  completion:(BUGeckoPreloadCompletion)completion;

@end

NS_ASSUME_NONNULL_END
