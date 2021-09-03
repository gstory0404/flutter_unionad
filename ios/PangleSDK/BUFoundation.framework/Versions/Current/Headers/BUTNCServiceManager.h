//
// Created by bytedance on 2020/12/15.
//

#import <Foundation/Foundation.h>
#import "BUTNCRequestParam.h"

@class BUNetworkRequest;

@interface BUTNCServiceConfig : NSObject

@property (nonatomic, copy, readonly) NSString *appKey;

@property(nonatomic, copy, readonly) NSString *tncPath;

@property(nonatomic, copy, readonly) NSArray<NSString *> *tncDomains;

@property(nonatomic, copy, readonly) BUTNCRequestParam *(^tncRequestParam)(void);
@end

__attribute__((objc_subclassing_restricted))
@interface BUTNCServiceManager : NSObject

+ (void)registerTNCServiceWithAppKey:(NSString *)appKey tncDomains:(NSArray<NSString *> *)tncDomains tncPath:(NSString *)tncPath requestParam:(BUTNCRequestParam * (^)(void))param;

+ (void)unregisterTNCServiceWithAppKey:(NSString *)appKey;

+ (NSString *)TNCUrlWithBaseUrl:(NSString *)baseUrl forRequest:(BUNetworkRequest *)request;

+ (void)refreshTNCDomainsWithAppKey:(NSString *)appKey;
@end
