//
//  NSPointerArray+Safely.h
//  BUAdSDK
//
//  Created by bytedance_yuanhuan on 2018/6/21.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPointerArray (BU_Safely)
- (id)bu_safelyAccessObjectAtIndex:(NSUInteger)index;
@end
