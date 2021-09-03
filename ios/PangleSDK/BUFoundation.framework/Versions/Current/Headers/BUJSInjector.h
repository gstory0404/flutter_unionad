//
//  BUJSInjector.h
//  BURexxar
//
//  Created by muhuai on 2017/6/17.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BUWebView;
/**
 BUWebView的JS注入器
 当页面加载完成后, 注入器会向WebView容器里注入一段JS脚本.
 
 使用场景:
 容器是其他人提供的, 但是你需要往里面注入一些脚本.
 
 有两个级别:
 1. webview级别, 只对当前webview生效. BUWebView.injector
 2. 全局级别, 对所有webview生效. [BUJSInjector sharedInstance]
 
 请自行根据需求使用, 不要滥用全局级别
 
 */

@interface BUJSInjector : NSObject

/**
 全局级别的注入器.
 需评估影响范围, 慎用

 @return 注入器
 */
+ (instancetype)sharedInstance;

/**
 对匹配正则的页面注入脚本
 非线程安全
 
 @param script 脚本
 @param regex 正则表达式
 @param key 该条规则的key, 用于remove和 检验规则唯一性
 @note 如果有多条规则成功匹配, 则会注入多段JS脚本
       多段注入会按照注册先后顺序, 并且web级别 > 全局级别
 */
- (void)addInjectRuleWithScript:(NSString *)script regex:(NSString *)regex key:(NSString *)key;

/**
 移除指定规则
 非线程安全
 
 @param key 规则的key
 */
- (void)removeScriptWithKey:(NSString *)key;

/**
 移除全部规则.
 非线程安全
 
 慎用..小心被人打...
 */
- (void)removeAllScript;

/**
 对webview注入 符合规则的脚本

 @param webview BUWebView
 */
- (void)injectScriptInWebView:(UIView<BUWebView> *)webview;
@end
