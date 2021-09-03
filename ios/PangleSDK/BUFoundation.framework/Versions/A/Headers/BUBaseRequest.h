//
//  BUBaseRequest.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/4/2.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///  HTTP Request method.
typedef NS_ENUM(NSInteger, BURequestMethod) {
    BURequestMethodGET = 0,
    BURequestMethodPOST,
    BURequestMethodHEAD,
    BURequestMethodPUT,
    BURequestMethodDELETE,
    BURequestMethodPATCH,
};

///  Request serializer type.
typedef NS_ENUM(NSInteger, BURequestSerializerType) {
    BURequestSerializerTypeHTTP = 0,
    BURequestSerializerTypeJSON,
};

///  Response serializer type, which determines response serialization process and
///  the type of `responseObject`.
typedef NS_ENUM(NSInteger, BUResponseSerializerType) {
    /// NSData type
    BUResponseSerializerTypeHTTP,
    /// JSON object type
    BUResponseSerializerTypeJSON,
};

///  Request priority
typedef NS_ENUM(NSInteger, BURequestPriority) {
    BURequestPriorityLow = -4L,
    BURequestPriorityDefault = 0,
    BURequestPriorityHigh = 4,
};

@protocol BU_AFMultipartFormData;

typedef void (^BUAFConstructingBlock)(id<BU_AFMultipartFormData> formData);
typedef void (^BUAFURLSessionTaskProgressBlock)(NSProgress *);

@class BUBaseRequest;

typedef void(^BURequestCompletionBlock)(__kindof BUBaseRequest *request);

@interface BUBaseRequest : NSObject

///  The underlying NSURLSessionTask.
///
///  @warning This value is actually nil and should not be accessed before the request starts.
@property (nonatomic, strong) NSURLSessionTask *requestTask;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) id responseJSONObject;
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) BURequestMethod requestMethod;
/// For post method, when httpbody can not be Serialized from NSDictionary json. if httpBody exists, please use httpBody directively and ignore 'requestArgument'
@property (nonatomic, strong) NSData *httpBody;

///  Shortcut for `requestTask.currentRequest`.当前活跃的request
@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;

///  Shortcut for `requestTask.originalRequest`.在task创建的时候传入的request(有可能会重定向)
@property (nonatomic, strong, readonly) NSURLRequest *originalRequest;

///  Shortcut for `requestTask.response`.
@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;

///  The response status code.
@property (nonatomic, readonly) NSInteger responseStatusCode;

///  The success callback. Note if this value is not nil and `requestFinished` delegate method is
///  also implemented, both will be executed but delegate method is first called. This block
///  will be called on the main queue.
@property (nonatomic, copy, nullable) BURequestCompletionBlock successCompletionBlock;

///  The failure callback. Note if this value is not nil and `requestFailed` delegate method is
///  also implemented, both will be executed but delegate method is first called. This block
///  will be called on the main queue.
@property (nonatomic, copy, nullable) BURequestCompletionBlock failureCompletionBlock;

///  Additional HTTP request header field.
- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary;

///  Request serializer type.
- (BURequestSerializerType)requestSerializerType;

///  Response serializer type. See also `responseObject`.
- (BUResponseSerializerType)responseSerializerType;

///  Request cache policy.
- (NSURLRequestCachePolicy)bu_requestCachePolicy;

//constructingBodyWithBlock:在此block种可以为上传的参数添加(拼接)新的需要的上传的数据,适用于上传给服务器的数据流比较大的时候
@property (nonatomic, copy, nullable) BUAFConstructingBlock constructingBodyBlock;

- (NSString *)requestUrl;
- (NSString *)cdnUrl;
- (NSString *)baseUrl;
- (NSTimeInterval)requestTimeoutInterval;
- (nullable id)requestArgument;
///  Whether the request is allowed to use the cellular radio (if present). Default is YES.
- (BOOL)allowsCellularAccess;
///  Nil out both success and failure callback blocks.
- (void)clearCompletionBlock;

@property (nonatomic) BURequestPriority requestPriority;

///  Should use CDN when sending request.
- (BOOL)useCDN;

#pragma mark - Request Action
///=============================================================================
/// @name Request Action
///=============================================================================

///  Append self to request queue and start the request.
- (void)start;

///  Remove self from request queue and cancel the request.
- (void)stop;

///  Convenience method to start the request with block callbacks.
- (void)startWithCompletionBlockWithSuccess:(nullable BURequestCompletionBlock)success
                                    failure:(nullable BURequestCompletionBlock)failure;

///  Return cancelled state of request task.
@property (nonatomic, readonly, getter=isCancelled) BOOL cancelled;

///  Executing state of request task.
@property (nonatomic, readonly, getter=isExecuting) BOOL executing;

@end

NS_ASSUME_NONNULL_END
