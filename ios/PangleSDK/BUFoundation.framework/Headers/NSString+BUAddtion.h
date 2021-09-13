//
//  NSString+URLEncoding.h
//  BUAdSDK
//
//  Created by carl on 2017/10/26.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BULanguageType) {//"万"转换规则
    BULanguageType_showWan     = 0,         //直接拼接万,默认
    BULanguageType_showNum     = 1,         //直接展示数字
};

@interface NSString (BU_URLCoding)
- (nullable NSString *)bu_URLEncodedString;
- (nullable NSString *)bu_URLDecodedString;
- (nullable NSString *)bu_URLEncodedStringWithCustomSet;
@end

@interface NSString (BU_Encryption)
- (nullable NSString *)bu_sha256;
/**
 * @brief 返回自身的md5
 * @return 返回自身的md5的16进制字串
 */
- (nullable NSString *)bu_MD5HashString;
@end

@interface NSString (BU_NumberToWan)
/// 数字转换成x万(以1w为界限，小于1w显示原始数字) 没有”万“走另一套展示逻辑
+ (NSString *)bu_numberToWan:(NSInteger)target wan:(NSString *)wan;

/// 大于1w就用k表示，不大于就直接展示多少个评分
+ (NSString *)bu_numberToThousand:(NSInteger)target;

@end

@interface NSString (BU_URLStringAppend)
/*
 *
 string转URL
 */
+ (nullable NSURL *)bu_URLWithURLString:(NSString *)str;
/*
 *
 string转字典
 */
+ (NSDictionary*)bu_parametersOfURLQueryString:(NSString*)urlString;

/*
 *
 url字符串拼接参数,需要判断是否是第一个
 */
+ (NSString *)bu_urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters;

+ (NSString *)bu_urlStringWithBaseUrlString:(NSString *)baseUrlString requestURLString:(NSString *)requestURLString;

+ (NSString *)bu_urlStringWithUrlString:(NSString *)urlString parameterString:(NSString *)parameterString;

/*
 * 格式转化
   222222 -> 222,222
 */
+ (NSString *)bu_convertNumberFormatter:(NSString *)str;

@end


@interface NSString (BU_Sandbox)
/**
 *  获取缓存路径
 *
 *  @return path where to cache
 */
- (NSString *)bu_CachePath;

/**
 * @brief 获取程序的用户文档目录的路径加上自身
 * @return 用户文档目录路径字串加上自身，该字符串是自动释放的
 */
- (NSString *)bu_DocumentsPath;
@end


@interface NSString(BU_JSONValue)

- (nullable id)bu_JSONValue:(NSError **)error;
+ (nullable id)bu_objectWithJSONData:(nullable NSData *)inData error:(NSError **)outError;

@end


@interface NSString(BU_Time)

+ (NSString*)bu_dateNowString;

+ (NSString*)bu_dateStringSince:(NSTimeInterval)timeInterval;

+ (NSNumber*)bu_currentInterval;

@end


@interface NSString(BU_Random)

/*  @deccription生成随机字符
 *  @param count 多少位随机数
 */
+ (NSString *)randomStringWithCount:(NSUInteger)count;
@end

@interface NSString (BU_Size)

- (CGSize)bu_boundingRectWithSize:(CGSize)size font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
