//
//  BULogMacros.h
//  BUFoundation
//
//  Created by Rush.D.Xzj on 2021/2/2.
//

#import <Foundation/Foundation.h>
#import "BULogManager.h"




/** LOG **/
#define BU_Log_Foundation(frmt, ...) BU_LOG_MAYBE(BUFoundationLog, BU_LOG_ENABLED, frmt, ##__VA_ARGS__)

#define BU_LOG_MAYBE(BULogTypeString, flg, frmt, ...)                       \
do {                                                      \
if(flg) [BULogManager debugLogWithFormat:@"[PangleUnion-%@]-[debug]-[%@]%@", BUSDKVersion, BULogTypeString, [NSString stringWithFormat:frmt,##__VA_ARGS__]];                       \
} while(0)

#define BU_LogErrorD(BULogType, frmt, ...) BU_LogBaseD(error, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogWaringD(BULogType, frmt, ...) BU_LogBaseD(warning, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogInfoD(BULogType, frmt, ...) BU_LogBaseD(info, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogDebugD(BULogType, frmt, ...) BU_LogBaseD(debug, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogVerboseD(BULogType, frmt, ...) BU_LogBaseD(verbose, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogInternalD(BULogType, frmt, ...) BU_LogBaseD(internal, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogServerD(BULogType, frmt, ...) BU_LogBaseD(server, BULogType, frmt, ##__VA_ARGS__)
#define BU_LogBaseD(level, BULogType, frmt, ...) [BULogManager level##LogWithFormat:@"[PangleUnion-%@]-[%s]-[%@]%@", BUSDKVersion, #level, BULogType, [NSString stringWithFormat:frmt, ##__VA_ARGS__]];



FOUNDATION_EXPORT NSString * const BUFoundationLog;
FOUNDATION_EXPORT BOOL BU_LOG_ENABLED;


