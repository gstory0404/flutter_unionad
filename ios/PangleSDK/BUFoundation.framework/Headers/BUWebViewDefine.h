//
//  BUWebViewDefine.h
//  BURexxar
//
//  Created by muhuai on 2017/5/17.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BURexxarEngine.h"
#import "BUJSInjector.h"

typedef NS_ENUM(NSInteger, BUWebViewNavigationType) {
    BUWebViewNavigationTypeLinkClicked,
    BUWebViewNavigationTypeFormSubmitted,
    BUWebViewNavigationTypeBackForward,
    BUWebViewNavigationTypeReload,
    BUWebViewNavigationTypeFormResubmitted,
    BUWebViewNavigationTypeOther
};

@protocol BUWebView;

@protocol BUWebViewDelegate <NSObject>

@optional
- (BOOL)webView:(UIView<BUWebView> *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(BUWebViewNavigationType)navigationType;

- (void)webViewDidStartLoad:(UIView<BUWebView> *)webView;

- (void)webViewDidFinishLoad:(UIView<BUWebView> *)webView;

- (void)webView:(UIView<BUWebView> *)webView didFailLoadWithError:(NSError *)error;

- (void)webViewWebContentProcessDidTerminate:(UIView<BUWebView> *)webView API_AVAILABLE(macosx(10.11), ios(9.0));

//二方页面有 domReady回调
- (void)webViewDomReady:(UIView<BUWebView> *)webView;
@end


/**
  BUWKWebView 都会实现此协议, 用来对平两个容器之间API的差异
 */
@protocol BUWebView <BURexxarEngine>

@property (nonatomic, strong ,readonly) UIScrollView *ttr_scrollView;

/**
 JS脚本注入器 使用说明见:BUJSInjector.h
 */
@property (nonatomic, strong, readonly) BUJSInjector *ttr_injector;
#pragma mark - Loading Content

- (void)ttr_loadRequest:(NSURLRequest *)request;

- (void)ttr_loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;


/**
 WK下特有的方法

 @param URL 本地文件URL, 注意需要为file://
 @param readAccessURL WK下可以指定获取一个本地目录的权限
 */
- (void)ttr_loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL;

- (void)ttr_stopLoading;

- (void)ttr_reload;

#pragma mark - Moving Back and Forward
- (BOOL)ttr_canGoBack;

- (BOOL)ttr_canGoForward;

- (void)ttr_goBack;

- (void)ttr_goForward;


#pragma mark - Multi Delegate
/**
BUWKWebView内部实现成多路代理, 按注册的顺序来依次询问.

 @param delegate webview代理
 */
- (void)ttr_addDelegate:(id<BUWebViewDelegate>)delegate;

/**
 移除指定代理

 @param delegate 需要移除的代理
 */
- (void)ttr_removeDelegate:(id<BUWebViewDelegate>)delegate;

/**
 移除所有代理
 */
- (void)ttr_removeAllDelegate;
@end

