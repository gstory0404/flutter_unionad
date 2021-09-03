//
//  HMDBUBacktraceLog.h
//  AppleCrashLog
//
//  Created by 谢俊逸 on 8/3/2018.
//

#import <Foundation/Foundation.h>
#import "HMDBUThreadBacktrace.h"

@interface HMDBUBacktraceLog : NSObject
+ (NSString *)backtraceLogStringWithBacktraceInfo:(HMDBUThreadBacktrace*)backtraceInfo;
@end

