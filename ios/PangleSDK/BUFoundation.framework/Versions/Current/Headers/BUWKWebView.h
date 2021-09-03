//
//  BUWKWebView.h
//  BURexxar
//
//  Created by muhuai on 2017/5/5.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "BUWebViewDefine.h"

@interface BUWKWebView : WKWebView<BUWebView>
/// 白屏检测
- (void)bu_detectBlankWebViewCompleteBlock:(void(^)(BOOL, NSError *))block;

/// 白屏检测百分比
- (void)bu_detectBlankPercentCompleteBlock:(void(^)(CGFloat bgColorPercent, NSError *error))block;
/// jsbridge 白屏检测百分比
- (void)bu_detectBlankPercentWithImageStr:(NSString *)imageStr completeBlock:(void(^)(CGFloat bgColorPercent, NSError *))block;
@end
