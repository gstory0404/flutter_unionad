//
//  HMDBULog.h
//  HeimdallrBU
//
//  Created by 谢俊逸 on 14/3/2018.
//

#import <Foundation/Foundation.h>
#define WatchDogIdentifier @"Heimdallr_WatchDog_Log"
#define OOMIdentifier @"Heimdallr_OOM_Log"
#define CrashIdentifier @"Heimdallr_Crash_Log"
#define ANRIdentifier @"Heimdallr_ANR_Log"
#define ExceptionIdentifier @"Heimdallr_Exception_Log"
#define ExceptionProtectIdentifier @"Heimdallr_ExceptionProtect_Log"
#define UserExceptionIdentifier @"Heimdallr_UserException_Log"
#define NetworkErrorIdentifier @"Heimdallr_Network_Log"

/// format 格式
#if defined(__LP64__)
#define FMT_LONG_DIGITS "16"
#define FMT_RJ_SPACES "18"
#else
#define FMT_LONG_DIGITS "8"
#define FMT_RJ_SPACES "10"
#endif

#define FMT_PTR_SHORT        @"0x%" PRIxPTR
#define FMT_PTR_LONG         @"0x%0" FMT_LONG_DIGITS PRIxPTR
#define FMT_PTR_RJ           @"%#" FMT_RJ_SPACES PRIxPTR
#define FMT_OFFSET           @"%" PRIuPTR
#define FMT_TRACE_PREAMBLE       @"%-4d%-31s " FMT_PTR_LONG
#define FMT_TRACE_UNSYMBOLICATED FMT_PTR_SHORT @" + " FMT_OFFSET
#define FMT_TRACE_SYMBOLICATED   @"%@ + " FMT_OFFSET

#define HMDBUAppleRedactedText @"<redacted>"

#define kExpectedMajorVersion 3


typedef NS_ENUM(NSUInteger, HMDBULogType) {
    HMDBULogWatchDog,
    HMDBULogOOM,
    HMDBULogANR,
    HMDBULogCrash,
    HMDBULogException,
    HMDBULogExceptionProtect,
    HMDBULogUserException,
    HMDBULogNetworkError
};
