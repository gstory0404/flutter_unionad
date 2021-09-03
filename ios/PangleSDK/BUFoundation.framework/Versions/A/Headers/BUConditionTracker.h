//
//  BUConditionTracker.h
//  BUFoundation
//
//  Created by Willie on 2021/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL (^BUConditionBlock)(void);
typedef void (^BUActionBlock)(void);

/// 条件轮询器：每秒轮询指定的条件，若条件满足则执行指定的行为
@interface BUConditionTracker : NSObject

/// 通过指定的条件 block 和行为 block 来构建一个
/// @param condition 每秒轮询的条件，需要返回一个 BOOL 值
/// @param action 当轮询条件满足时，需要执行的行为
/// @param retryCount 轮询次数，当实际轮询次数超过指定次数后轮询自动停止，并释放条件和行为 block
- (instancetype)initWithConditon:(BUConditionBlock)condition
                          action:(BUActionBlock)action
                      retryCount:(NSInteger)retryCount;

/// 开始轮询
- (void)start;
/// 停止轮询并释放资源
- (void)stop;

@end

NS_ASSUME_NONNULL_END
