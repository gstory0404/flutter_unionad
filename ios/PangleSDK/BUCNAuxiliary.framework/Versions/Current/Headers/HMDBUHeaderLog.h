//
//  HMDBUHeaderLog.h
//  HeimdallrBU
//
//  Created by 谢俊逸 on 12/3/2018.
//

#import <Foundation/Foundation.h>
#import "HMDBULog.h"

#ifdef __cplusplus
extern "C" {
#endif
void hmdbu_setup_log_header(void); // 初始化header数据
char *hmdbu_log_header(HMDBULogType logType); // 获取堆栈header，必须先调用hmdbu_setup_log_header完成初始化
#ifdef __cplusplus
}  // extern "C"
#endif

@interface HMDBUHeaderLog : NSObject
+ (NSString *)hmdbuHeaderLogString:(HMDBULogType)logType;
@end
