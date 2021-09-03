
//  BUThreadSafeDictionary.h
//  Created by Siwant on 2018/1/22.
//  Copyright © 2018年 bytedance. All rights reserved.

#import <Foundation/Foundation.h>

@interface BUThreadSafeDictionary: NSMutableDictionary
- (id)objectForKey:(id <NSCopying>)aKey;
- (id)valueForKey:(id)aKey;
- (void)setObject:(id)object forKey:(id <NSCopying>)aKey;
- (void)setValue:(id)value forKey:(NSString *)key;
- (void)removeAllObjects;
- (void)removeObjectForKey:(id <NSCopying>)aKey;
- (NSDictionary *)dictionary;
- (NSArray *)allKeys;
- (NSArray *)allValues;
- (void)removeObjectsForKeys:(NSArray *)keyArray;
@end
