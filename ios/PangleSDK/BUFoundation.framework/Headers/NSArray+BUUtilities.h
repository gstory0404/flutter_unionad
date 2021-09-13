//
//  NSMutableArray+Utilities.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/2/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (BU_Utilities)

- (void)bu_safeAddObject:(id)object;
- (void)bu_safeAddNilObject;
- (void)bu_safeInsertObject:(id)object atIndex:(NSUInteger)index;
- (void)bu_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)bu_safeRemoveObject:(id)object;
- (nullable id)bu_objectAtIndexSafely:(NSUInteger)index;
- (void)bu_removeObjectAtIndexSafely:(NSUInteger)index;






@end

@interface NSArray(BU_JSONValue)
- (nullable NSString *)bu_JSONRepresentation:(NSError **)error;



- (void)bu_forEachWithBlock:(void(^)(id item))block;
- (void)bu_forEachWithIndexBlock:(void(^)(id item, NSInteger index))indexBlock;

- (NSArray *)bu_mapWithBlock:(id(^)(id item))block;
- (NSArray *)bu_mapWithIndexBlock:(id(^)(id item, NSInteger index))indexBlock;

- (NSArray *)bu_filterWithConditionBlock:(BOOL(^)(id item))conditionBlock;
- (NSArray *)bu_filterWithIndexConditionBlock:(BOOL(^)(id item, NSInteger index))indexConditionBlock;

- (BOOL)bu_someWithConditionBlock:(BOOL(^)(id item))conditionBlock;
- (BOOL)bu_someWithIndexConditionBlock:(BOOL(^)(id item, NSInteger index))indexConditionBlock;

- (BOOL)bu_everyWithConditionBlock:(BOOL(^)(id item))conditionBlock;
- (BOOL)bu_everyWithIndexConditionBlock:(BOOL(^)(id item, NSInteger index))indexConditionBlock;

- (id)bu_reduceWithBlock:(id(^)(id item1, id item2))block initial:(id)initial;



- (id)bu_findWithConditionBlock:(id(^)(id item))conditionBlock;
- (id)bu_findWithIndexConditionBlock:(id(^)(id item, NSInteger index))indexConditionBlock;
@end

NS_ASSUME_NONNULL_END
