//
//  BURexxarEngine.h
//  BURexxar
//
//  Created by muhuai on 2017/4/26.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUStaticPlugin.h"

@protocol BUJSBAuthorization;
@protocol BURexxarEngine <NSObject>

@required

/**
 engine所在的ViewController, 提供JSBridge更多的上下文. 可为空.
 */
@property (nonatomic, weak) UIViewController *ttr_sourceController;

/**
 engine所挂载的静态plugin集合
 */
@property (nonatomic, strong) BUStaticPlugin *ttr_staticPlugin;

/**
 engine当前页面地址
 */
@property (nonatomic, strong, readonly) NSURL *ttr_url;

@optional
/**
 JSBridge授权器, 每个业务方可自行注入. 默认为nil, 全部public权限
 */
@property (nonatomic, strong) id<BUJSBAuthorization> ttr_authorization;

#pragma mark - Executing JavaScript
@required

/**
 注入JavaScrip

 @param script 需要注入的script
 @param completion 完成的回调
 */
- (void)ttr_evaluateJavaScript:(NSString *)script completionHandler:(void (^)(id result, NSError *error))completion;



/**
 对容器内发送通知

 @param event 通知名称
 @param data 携带的信息
 */
- (void)ttr_fireEvent:(NSString *)event data:(NSDictionary *)data;
@end
