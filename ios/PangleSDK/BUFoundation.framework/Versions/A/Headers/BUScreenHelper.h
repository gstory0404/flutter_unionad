//
//  BDUScreenHelp.h
//  BUAdSDK
//
//  Created by bytedance_yuanhuan on 2018/11/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//设备类型
typedef NS_ENUM(NSInteger, BUDeviceMode) {
    //iPad
    BUDeviceModePad,
    //iPhone6plus,iPhone6Splus
    BUDeviceMode736,
    //iPhone6,iPhone6S
    BUDeviceMode667,
    //iPhone5,iPhone5C,iPhone5S,iPhoneSE
    BUDeviceMode568,
    //iPhone4,iPhone4s
    BUDeviceMode480,
    //iPhoneX,iphoneXS
    BUDeviceMode812,
    //iphoneXR,iphoneRS Max
    BUDeviceMode896
};

NS_ASSUME_NONNULL_BEGIN

@interface BUScreenHelper: NSObject

/**
 *  判断设备是iPhone4, iPhone4S
 *
 *  @return Yes or No
 */
+ (BOOL)is480Screen;

/**
 *  判断设备是iPhone5, iPhone5C, iPhone5S, iPhoneSE
 *
 *  @return Yes or No
 */
+ (BOOL)is568Screen;

/**
 *  判断设备是iPhone6,iPhone6S
 *
 *  @return Yes or No
 */
+ (BOOL)is667Screen;

/**
 *  判断设备是iPhone6plus, iPhone6Splus
 *
 *  @return Yes or No
 */
+ (BOOL)is736Screen;
// iphone6，iphone6 plus

/**
 *  判断设备是iPhoneX,iphoneXS
 *
 *  @return Yes or No
 */
+ (BOOL)is812Screen;

/**
 *  判断设备是iphoneXR,iphoneRS Max
 *
 *  @return Yes or No
 */
+ (BOOL)is896Screen;

/**
 *  判断设备的宽度大于320
 *
 *  @return Yes or No
 */
+ (BOOL)isScreenWidthLarge320;

/**
 *  判断设备是iPad
 *
 *  @return Yes or No
 */
+ (BOOL)isPadDevice;

/**
 *  判断设备是iPad pro
 *
 *  @return Yes or No
 */
+ (BOOL)isIpadProDevice;

/**
 *  获取设备类型
 *
 *  @return BUDeviceType类型
 */
+ (BUDeviceMode)getDeviceType;

/**
 *  分辨率，区分横竖屏，形如@"414*736"
 *  @return 横竖屏返回样式，横屏样式@"736*414"，竖屏样式@"414*736"
 */
+ (nullable NSString *)resolutionString;

/**
 *  分辨率，区分横竖屏，形如@"414x736"
 *  @return 横竖屏返回样式，横屏样式@"736x414"，竖屏样式@"414x736"
 */
+ (NSString *)displayDensity;

@end

NS_ASSUME_NONNULL_END
