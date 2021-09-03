//
//  NSTimer+BUBlockSupport.h
//  BUAdSDK
//
//  Created by gdp on 2017/12/23.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BU_BlockSupport)

+ (NSTimer *)bu_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                          block:(void (^)(NSTimer *))block;
@end
