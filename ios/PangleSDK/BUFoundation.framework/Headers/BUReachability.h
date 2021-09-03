/*
 File: BUReachability.h
 Abstract: Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 Version: 3.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef NS_ENUM(NSInteger, BUNetWorkTypeCode) {
    // 初始状态，未连接
    BUNetWorkTypeCode_None = -1,
    // 未知
    BUNetWorkTypeCode_Unknown = 0,
    BUNetWorkTypeCode_Mobile = 1,
    BUNetWorkTypeCode_2G = 2,
    BUNetWorkTypeCode_3G = 3,
    BUNetWorkTypeCode_Wifi = 4,
    BUNetWorkTypeCode_4G = 5,
    BUNetWorkTypeCode_5G = 6,
};

typedef NS_ENUM(NSInteger) {
    // 程序无法判断出 App 的网络权限设置
    kBUNetworkAuthorizationStatusCantDetermined = 0,
    // App 未开启蜂窝数据网络权限
    kBUNetworkAuthorizationStatusCellNotPermitted,
    // App 未开启无线局域网与蜂窝移动网络权限，此项仅可能在国行 iPhone 手机上出现
    kBUNetworkAuthorizationStatusWLANAndCellNotPermitted,
} kBUNetworkAuthorizationStatus;

extern NSString *kBUReachabilityChangedNotification;

// 是否开启 “网络状态检测” 的优化，需要外部调用方以 [[NSUserDefaults standardUserDefaults] setBool:forKey:] 方式写入
extern NSString * const BUReachabilityDetectOptimizeKey;

@interface BUReachability : NSObject


/**
 判断指定域名的连通性

 @param hostName 域名
 @return BUReachability对象
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;


/**
 判断指定IP地址的连通性

 @param hostAddress IP地址
 @return BUReachability对象
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr_in *)hostAddress;

/**
 判断网络默认连接的连通性（应用连接到指定host主机时除外）

 @return BUReachability对象
 */
+ (instancetype)reachabilityForInternetConnection;

/**
 开始在当前runloop监听连通性通知

 @return 是否成功开始监听
 */
- (BOOL)startNotifier;


/**
 结束监听连通性通知
 */
- (void)stopNotifier;


/**
 当前连通性状态

 @return NetworkStatus枚举值
 */
- (BUNetWorkTypeCode)currentReachabilityStatus;

/**
 是否需要连接。如WWAN需要首先建立一个可用连接才能被激活。WiFi可能需要一个VPN连接等

 @return 是否需要连接
 */
- (BOOL)connectionRequired;


/**
 获取 App 当前的网络权限设置状态
 
 因苹果尚未提供网络权限判断的 API，此方法目前只是在网络 NotReachable 时检查系统连接状态，
 利用排除法推断出 App 当前没有 蜂窝数据网络权限 或者 WIFI及蜂窝数据网络权限，排除原理参见
 https://wiki.bytedance.net/pages/viewpage.action?pageId=107808003
 
 在其它情况下（例如网络 Reachable 或者飞行模式）均返回 CantDetermined，上层业务调用方需注意

 @return 参见 kBUNetworkAuthorizationStatus 定义
 */
- (kBUNetworkAuthorizationStatus)currentNetworkAuthorizationStatus;

@end


@interface BUReachability (Cellular)

/**
 2G网络是否连通

 @return 是否连通
 */
+ (BOOL)is2GConnected;

/**
 3G网络是否连通
 
 @return 是否连通
 */
+ (BOOL)is3GConnected;

/**
 4G网络是否连通
 
 @return 是否连通
 */
+ (BOOL)is4GConnected;


/**
 2017.5.22添加
 借鉴微信方式判断当前网络是否连通
 
 @return 网络是否可以联调
 */
+ (BOOL)isNetworkConnected;

@end



