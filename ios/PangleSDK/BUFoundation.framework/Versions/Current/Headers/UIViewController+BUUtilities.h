//
//  UIViewController+BUUtilities.h
//  BUAdSDK
//
//  Created by Siwant on 2019/4/11.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BUUtilities)

- (void)bu_safelyPresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;



// 获取当前最后一个被present出的VC，如果没有返回self
- (UIViewController *)bu_presentingViewController;
// 获取当前最后一个被present出的VC，如果没有返回window的最上的topVC
+ (UIViewController *)bu_presentingViewController;

// 获取广义mainWindow的rootViewController
+ (nullable UIViewController*)bu_mainWindowRootViewController;

// 获取指定UIResponder的链下游第一个ViewController对象
+ (nullable UIViewController*)bu_nextViewControllerFor:(UIResponder* _Nullable)responder;

// 获取指定UIResponder的链下游第一个UINavigationController对象
+ (nullable UINavigationController*)bu_nextNavigationControllerFor:(UIResponder* _Nullable)responder;

/** 查找当前显示的ViewController*/
+ (UIViewController *)bu_topViewController;

+ (UIViewController *)bu_recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC;


@end

NS_ASSUME_NONNULL_END
