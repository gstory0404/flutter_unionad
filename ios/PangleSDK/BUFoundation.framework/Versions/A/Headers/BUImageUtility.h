//
//  BUImageUtility.h
//  BUAdSDK
//
//  Created by Siwant on 2019/8/8.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUImageUtility : NSObject
/// 返回类型不只是UIImage，也包括BUGifImage
+ (UIImage *_Nullable)imageWithData:(NSData *_Nullable)data;
@end

NS_ASSUME_NONNULL_END
