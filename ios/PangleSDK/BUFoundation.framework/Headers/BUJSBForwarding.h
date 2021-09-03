//
//  BUJSBForwarding.h
//  BURexxar
//
//  Created by muhuai on 2017/4/27.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUJSBCommand.h"
#import "BURexxarEngine.h"
#import "BUJSBDefine.h"

@interface BUJSBForwarding : NSObject

+ (instancetype)sharedInstance;


/**
 转发到对应的插件

 @param command JSB命令
 @param engine Hybrid容器, 可是webview, RNView, weex. 实现此协议即可
 @param completion 完成回调
 */
- (void)forwardJSBWithCommand:(BUJSBCommand *)command engine:(id<BURexxarEngine>)engine completion:(BUJSBResponse)completion;

/**
 注册JSBridge别名
 
 @param alias 新名
 @param orig 原名
 */
- (void)registeJSBAlias:(NSString *)alias for:(NSString *)orig;


/**
 原名 -> 别名

 @param orig 原名
 @return 别名
 */
- (NSString *)aliasJSBForOrig:(NSString *)orig;
@end

