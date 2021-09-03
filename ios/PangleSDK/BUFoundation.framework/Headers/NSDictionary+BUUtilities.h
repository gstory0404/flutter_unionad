//
//  NSMutableDictionary+Utilities.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/2/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (BU_Helper)

#pragma mark - Safe Value Type From Key
- (nullable NSString *)bu_stringForKey:(NSString *)key defaultValue:(nullable NSString *)defalutValue;
- (NSInteger)bu_integerForKey:(NSString *)key defaultValue:(NSInteger)defalutValue;
- (long)bu_longForKey:(NSString *)key defaultValue:(long)defalutValue;
- (long long)bu_longLongForKey:(NSString *)key defaultValue:(long long)defalutValue;
- (NSTimeInterval)bu_timeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defalutValue;
- (float)bu_floatForKey:(NSString *)key defaultValue:(float)defalutValue;
- (nullable NSArray *)bu_arrayForKey:(NSString *)key defaultValue:(nullable NSArray *)defalutValue;
- (nullable NSDictionary *)bu_dictionaryForKey:(NSString *)key defaultValue:(nullable NSDictionary *)defalutValue;

@end

@interface NSDictionary(BU_JSONValue)

- (nullable NSString *)bu_JSONRepresentation:(NSError **)error;
+ (nullable NSDictionary *)bu_dictionaryWithJSONData:(NSData *)inData error:(NSError **)outError;
+ (nullable NSDictionary *)bu_dictionaryWithJSONString:(NSString *)inJSON error:(NSError **)outError;
@end


@interface NSMutableDictionary (BU_Helper)

#pragma mark - Safe Set Object For Key
- (void)bu_setObject:(id)object forKey:(id<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
