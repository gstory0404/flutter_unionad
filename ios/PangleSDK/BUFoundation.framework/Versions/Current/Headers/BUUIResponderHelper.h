//
//  BUUIResponderHelper.h
//  BUSDKProject
//
//  Created by ranny_90 on 2017/5/20.
//  Copyright © 2017年 ranny_90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUUIResponderHelper : NSObject

// 获取当前应用的广义mainWindow
+ (nullable UIWindow *)mainWindow __attribute__((deprecated("Use bu_mainWindow in UIWindow+BUUtilities instead.")));

// 广义mainWindow的大小（兼容iOS7）
+ (CGSize)windowSize __attribute__((deprecated("Use bu_windowSize in UIWindow+BUUtilities instead.")));


// 获取广义mainWindow的rootViewController
+ (nullable UIViewController*)mainWindowRootViewController __attribute__((deprecated("Use bu_mainWindowRootViewController in UIViewController+BUUtilities instead.")));

// 获取指定UIResponder的链下游第一个ViewController对象
+ (nullable UIViewController*)nextViewControllerFor:(UIResponder* _Nullable)responder __attribute__((deprecated("Use bu_nextViewControllerFor: in UIViewController+BUUtilities instead.")));

// 获取指定UIResponder的链下游第一个UINavigationController对象
+ (nullable UINavigationController*)nextNavigationControllerFor:(UIResponder* _Nullable)responder __attribute__((deprecated("Use bu_nextNavigationControllerFor: in UIViewController+BUUtilities instead.")));

/** 查找当前显示的ViewController*/
+ (UIViewController *)topViewController __attribute__((deprecated("Use bu_topViewController in UIViewController+BUUtilities instead.")));

+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC __attribute__((deprecated("Use bu_recursiveFindCurrentShowViewControllerFromViewController: in UIViewController+BUUtilities instead.")));
@end

NS_ASSUME_NONNULL_END
