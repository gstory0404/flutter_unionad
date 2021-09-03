//
//  BUActionHelper.h
//  BUAdSDK
//
//  Created by carl on 2018/1/4.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+BUUtilities.h"

@interface BURouter : NSObject
+ (void)presentFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;
@end
