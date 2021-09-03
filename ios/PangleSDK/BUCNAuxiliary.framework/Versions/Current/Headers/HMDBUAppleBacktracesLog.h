//
//  HMDBUAppleBacktracesLog.h
//  HeimdallrBU
//
//  Created by 谢俊逸 on 2019/3/18.
//

#import <Foundation/Foundation.h>
#import "HMDBUAsyncThread.h"
#import "HMDBUThreadBacktrace.h"
#import "HMDBULog.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMDBUAppleBacktracesLog : NSObject

#pragma mark - deprecated API

+ (NSString *)getAllThreadsLogByKeyThread:(thread_t)keyThread
                             skippedDepth:(NSUInteger)skippedDepth
                                  logType:(HMDBULogType)type __attribute__((deprecated("已废弃，请使用New API")));

+ (NSString *)getAllThreadsLogBySkippedDepth:(NSUInteger)skippedDepth
                                     logType:(HMDBULogType)type __attribute__((deprecated("已废弃，请使用New API")));

+ (NSString *)getAllThreadsLogByKeyThread:(thread_t)keyThread
                             skippedDepth:(NSUInteger)skippedDepth
                                  logType:(HMDBULogType)type
                                exception:(NSString * _Nullable)exceptionField
                                   reason:(NSString * _Nullable)reasonField __attribute__((deprecated("已废弃，请使用New API")));

+ (NSString *)getMainThreadLogBySkippedDepth:(NSUInteger)skippedDepth
                                     logType:(HMDBULogType)type __attribute__((deprecated("已废弃，请使用New API")));

+ (NSString *)getCurrentThreadLogBySkippedDepth:(NSUInteger)skippedDepth
                                        logType:(HMDBULogType)type __attribute__((deprecated("已废弃，请使用New API")));

+ (NSString *)getThreadLog:(thread_t)thread
            BySkippedDepth:(NSUInteger)skippedDepth
                   logType:(HMDBULogType)type __attribute__((deprecated("已废弃，请使用New API")));


#pragma mark - New API

+ (thread_t)mainThread;
+ (thread_t)currentThread;

/**
 * 参数说明：
 * @param keyThread 标注为崩溃的线程，Slardar平台根据该线程堆栈进行聚合。
 *                  - 主线程：[HMDBUAppleBacktracesLog mainThread]
 *                  - 当前线程：[HMDBUAppleBacktracesLog currentThread]
 * @param skippedDepth 当前调用的线程索要忽略的调用栈深度
 * @param maxThreadCount 限制生成日志的最大线程数
 *                      - 0表示不做限制
 *                      - 若当前线程数大于设置最大线程数，取线程队列的前N个生成堆栈信息
 * @param suspend 获取线程堆栈时是否对线程进行挂起
 *                - 挂起线程获取的堆栈准确无误，但会损失部分性能
 *                - 不进行挂起可能会造成堆栈信息失真
 */

// 以下为同步获取log方法，堆栈获取为较耗操作，在主线程时调用，请使用下面的异步方法
+ (NSString * _Nullable)getAllThreadsLogByKeyThread:(thread_t)keyThread
                                     maxThreadCount:(NSUInteger)maxThreadCount
                                       skippedDepth:(NSUInteger)skippedDepth
                                            logType:(HMDBULogType)type
                                            suspend:(BOOL)suspend
                                          exception:(NSString * _Nullable)exception
                                             reason:(NSString * _Nullable)reason;

+ (NSString * _Nullable)getThreadLogByThread:(thread_t)keyThread
                                skippedDepth:(NSUInteger)skippedDepth
                                     logType:(HMDBULogType)type
                                     suspend:(BOOL)suspend
                                   exception:(NSString * _Nullable)exception
                                      reason:(NSString * _Nullable)reason;

// 以下为异步方法，在主线程调用推荐使用异步方法避免耗时而卡死
+ (void)getAllThreadsLogByKeyThread:(thread_t)keyThread
                     maxThreadCount:(NSUInteger)maxThreadCount
                       skippedDepth:(NSUInteger)skippedDepth
                            logType:(HMDBULogType)type
                            suspend:(BOOL)suspend
                          exception:(NSString * _Nullable)exception
                             reason:(NSString * _Nullable)reason
                           callback:(void(^)(BOOL success, NSString *log))callback;

+ (void)getThreadLogByThread:(thread_t)keyThread
                skippedDepth:(NSUInteger)skippedDepth
                     logType:(HMDBULogType)type
                     suspend:(BOOL)suspend
                   exception:(NSString * _Nullable)exception
                      reason:(NSString * _Nullable)reason
                    callback:(void(^)(BOOL success, NSString *log))callback;

+ (NSString *_Nullable)logWithBacktraces:(NSArray <HMDBUThreadBacktrace *>*)backtraces
                                    type:(HMDBULogType)type
                               exception:(NSString * _Nullable)exceptionField
                                  reason:(NSString * _Nullable)reasonField;

@end

NS_ASSUME_NONNULL_END
