//
//  BUAdNetworkRequest.h
//  BUFoundation
//
//  Created by bytedance on 2020/12/15.
//

#import "BUBaseRequest.h"
#import "BUTNCServiceManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUNetworkRequest : BUBaseRequest

@property (nonatomic,copy  ) NSString *buRequestUrl;
@property (nonatomic,strong) NSDictionary *parameter;
@property (nonatomic,assign) BURequestMethod method;
@property (nonatomic,assign) BURequestSerializerType buRequestSerializerType;
@property (nonatomic,assign) BUResponseSerializerType buResponseSerializerType;

- (instancetype)initWithUrl:(NSString * _Nullable)url
                     method:(BURequestMethod)method
                  parameter:(NSDictionary * _Nullable)parameter;

+ (instancetype)requestWithURL:(NSString *)url
                        method:(BURequestMethod)method
                     parameter:(NSDictionary *)paraDic
         completionWithSuccess:(BURequestCompletionBlock  _Nullable)success
                       failure:(BURequestCompletionBlock _Nullable)failure;

+ (instancetype)requestWithURL:(NSString *)url
                     parameter:(NSDictionary *)paraDic
         completionWithSuccess:(BURequestCompletionBlock _Nullable)success
                       failure:(BURequestCompletionBlock _Nullable)failure;



@end

@interface BUNetworkRequest (TNC)
// 使用TNC服务的标识，自定义，唯一即可
- (NSString *)TNCServiceKey;

// 请求失败回调，如果需要TNC，请使用`failureCompletionBlockWithTNC`替换`failureCompletionBlock`的实现
- (BURequestCompletionBlock)failureCompletionBlockWithTNC;

// 请求成功回调，如果需要TNC，请使用`successCompletionBlockWithTNC`替换`successCompletionBlock`的实现
- (BURequestCompletionBlock)successCompletionBlockWithTNC;

@end

NS_ASSUME_NONNULL_END
