//
//  BUGeckoPreloadManager.h
//  BUAdSDK
//
//  Created by wangyanlin on 2020/6/29.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kBUGeckoInitDoneNotificationName;

typedef void (^BUPreloadCompletion)(NSData * _Nullable data,NSDictionary * _Nullable respHeader);
typedef void (^BUPreloadTrackBlock)(NSObject *model,NSString *label,NSDictionary *parameter);
typedef void (^BUSyncDataCompletion)(BOOL success,NSDictionary *info);
@interface BUGeckoPreloadManager : NSObject

@property (nonatomic, strong) NSMapTable *mapTable;

@property (nonatomic, strong) NSMutableDictionary *geckoDict;

@property (nonatomic, copy) BUPreloadTrackBlock trackBlock;

+ (instancetype)sharedInstance;

+ (void)setupSDKWithTerritory:(NSString *)territory
                     IESGeckoKitAppId:(NSString *)IESGeckoKitAppId
          IESGeckoKit_CACHE_DIRECTORY:(NSString *)IESGeckoKit_CACHE_DIRECTORY
                 IESGeckoKitAccessKey:(NSString *)IESGeckoKitAccessKey
                  IESGeckoKit_Domains:(NSArray *)IESGeckoKit_Domains
                             ZipBlock:(id)zipBlock;

//1.本地zip 包已经被删除了,自动去下载
//2.如果zip需要更新,会自动更新
//3.本地有zip, 并且不需要更新. 不做处理
+ (void)syncResourcesParamsWithChannel:(NSArray <id>*)materialArray hosts:(NSArray *)hosts;

+ (BOOL)geckoDidSetup;
+ (void)registAccessKey:(NSString *)ak;
+ (void)setGeckoDeviceID:(NSString *)deviceID;
+ (void)syncResourcesParamsWithAccessKey:(NSString *)ak
                                channels:(NSArray<NSString *> *)channelIds
                                   hosts:(NSArray *)hosts
                              completion:(BUSyncDataCompletion _Nullable)completion;

+ (void)asyncGetDataWithInfo:(NSDictionary *)info
                   accessKey:(NSString *)ak
                     channel:(NSString *)channel
                  completion:(BUPreloadCompletion)completion;

+ (void)asyncGetDataWithInfo:(NSDictionary *)info completion:(BUPreloadCompletion)completion;

/**
* @brief 返回文件版本；如果文件未激活，则返回0
*/
+ (uint64_t)packageVersionForAccessKey:(NSString *)accessKey channel:(NSString *)channel;

@end

NS_ASSUME_NONNULL_END
