//
//  UIWindow+BUUtilities.h
//  BUFoundation
//
//  Created by Rush.D.Xzj on 2020/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (BUUtilities)
// 获取当前应用的广义mainWindow
+ (nullable UIWindow *)bu_mainWindow;

// 广义mainWindow的大小（兼容iOS7）
+ (CGSize)bu_windowSize;

@end

NS_ASSUME_NONNULL_END
