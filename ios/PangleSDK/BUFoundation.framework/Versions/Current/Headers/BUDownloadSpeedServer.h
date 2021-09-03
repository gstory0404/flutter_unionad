//
//  BUDownloadSpeedServer.h
//  BUFoundation
//
//  Created by bytedance on 2021/4/22.
//

#import <Foundation/Foundation.h>

@class BUDownloadSpeedModel;

NS_ASSUME_NONNULL_BEGIN

@interface BUDownloadSpeedServer : NSObject

+ (instancetype)server;

- (void)startDownloadWithUrl:(NSURL *)url;

- (BUDownloadSpeedModel *)downloadingWithUrl:(NSURL *)url;

- (void)finishDownloadWithUrl:(NSURL *)url;

- (double)downloadSpeeds;

@end

@interface BUDownloadSpeedModel : NSObject

@property (atomic, assign) NSTimeInterval startDownloadTime;

@property (atomic, assign) NSTimeInterval finishDownloadTime;

@property (atomic, assign)    NSInteger downloadSize;

@property (nonatomic, assign) double speed;

@end

NS_ASSUME_NONNULL_END
