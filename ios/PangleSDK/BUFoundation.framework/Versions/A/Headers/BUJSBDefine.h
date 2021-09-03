//
//  BUJSBDefine.h
//  BURexxar
//
//  Created by muhuai on 2017/5/5.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BURexxarEngine.h"

#define BU_EXPORT_HANDLER(NAME) - (void)NAME##WithParam:(NSDictionary *)param callback:(BUJSBResponse)callback webView:(UIView<BURexxarEngine> *)webview controller:(UIViewController *)controller;

#define _BU_HANDLER_SET(NAME, HANDLERS) \
- (NSSet<NSString *> *)NAME { \
if (![HANDLERS isKindOfClass:[NSArray class]]) {\
return nil;\
}\
return [NSSet setWithArray:HANDLERS];\
}

#define ARRAY(...) [NSArray arrayWithObjects: (id []){ __VA_ARGS__ } count: sizeof((id []){ __VA_ARGS__ }) / sizeof(id)]

#define BU_PROTECTED_HANDLER(...) \
_BU_HANDLER_SET(protectedHandlerSet, ARRAY(__VA_ARGS__))

#define BU_PRIVATE_HANDLER(...) \
_BU_HANDLER_SET(privateHandlerSet, ARRAY(__VA_ARGS__))

#define BU_CALLBACK_SUCCESS \
if (callback) {\
callback(BUJSBMsgSuccess, @{@"code": @"1"});\
}\

#define BU_CALLBACK_FAILED \
if (callback) {\
callback(BUJSBMsgFailed, @{@"code": @"0"});\
}\

#define BU_CALLBACK_FAILED_MSG(msg) \
if (callback) {\
callback(BUJSBMsgFailed, @{@"code": @"0", @"msg": [NSString stringWithFormat:msg]? :@""});\
}\

#define BU_CALLBACK_WITH_MSG(status, msg) \
if (callback) {\
callback(status, @{@"code": status == BUJSBMsgSuccess? @"1": @"0", @"msg": [NSString stringWithFormat:msg]? [NSString stringWithFormat:msg] :@""});\
}\


typedef NS_ENUM(NSUInteger, BUJSBInstanceType) {
    BUJSBInstanceTypeNormal, //每次调用都是不同实例(默认, 推荐)
    BUJSBInstanceTypeGlobal, //全局单例, 需要实现 +(instance)sharedPlugin;
    BUJSBInstanceTypeWebView, //对同一个webview复用一个实例
};

typedef NS_ENUM(NSUInteger, BUJSBAuthType){
    BUJSBAuthPublic, // 所有均可调用(默认)
    BUJSBAuthProtected, //内部domain，及外部授权可调用
    BUJSBAuthPrivate // 仅内部domain，appinfo不可见
};

typedef enum : NSUInteger {
    BUJSBMsgSuccess,
    BUJSBMsgFailed,
    BUJSBMsgParamError,
    BUJSBMsgNoHandler,
    BUJSBMsgNoPermission
} BUJSBMsg;

typedef NS_ENUM(NSInteger, BUJSBResultCode){
    BUJSBResultCodeError = -2,      // jsb结果错误cod回传
    BUJSBResultCodeSuccess = 200,   // jsb结果成功cod回传
};

typedef void(^BUJSBResponse)(BUJSBMsg, NSDictionary *);
