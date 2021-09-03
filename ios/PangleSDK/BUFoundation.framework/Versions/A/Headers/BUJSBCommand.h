//
//  BUJSBMessage.h
//  BURexxar
//
//  Created by muhuai on 2017/4/26.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUJSBCommand : NSObject

@property (nonatomic, copy) NSString *messageType;

@property (nonatomic, copy) NSString *eventID;

@property (nonatomic, copy) NSString *callbackID;

@property (nonatomic, copy) NSDictionary *params;


/**
 前端传过来的方法名, 有"isLogin" 和 "TTRLogin.isLogin"两种格式
 */
@property(nonatomic, copy) NSString *fullName;

/**
 经过别名映射后, 该property为 映射前的fullName
 */
@property(nonatomic, copy) NSString *origName;

/**
 动态plugin的 类名
 */
@property(nonatomic, copy) NSString *className;


/**
 动态plugin的 方法名
 */
@property(nonatomic, copy) NSString *methodName;

/**
 没卵用
 */
@property(nonatomic, copy) NSString *JSSDKVersion;

- (instancetype)initWithDictonary:(NSDictionary *)dic;

- (NSString *)toJSONString;
@end
