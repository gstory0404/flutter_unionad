//
//  BUDynamicPlugin.h
//  BURexxar
//
//  Created by muhuai on 2017/4/26.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUJSBDefine.h"
#import "BURexxarEngine.h"


//推荐使用动态的方式
/**
 使用方法:
 1.继承BUDynamicPlugin
 2.在.h中使用宏 BU_EXPORT_HANDLER(abc)声明需要暴露的方法
 3.在.m中实现此方法, 输入-(void)abc 即可获得ide补全提示
 4.通过传入的callback来回调执行结果. 注意.无论成功与否都必须执行这个callback
 */
@interface BUDynamicPlugin : NSObject

/**
 plugin执行时所处的engine
 */
@property (nonatomic, weak) id<BURexxarEngine> engine;


/**
 BUJSBInstanceTypeGlobal时 需要实现此方法, 没有特殊需要 不推荐使用

 @return 单例plugin
 */
+ (instancetype)sharedPlugin;

+ (BUJSBInstanceType)instanceType;
@end
