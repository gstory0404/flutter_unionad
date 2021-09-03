//
//  BUUserAgentHelper.h
//  BUAdSDK
//
//  Created by cuiyanan on 2019/9/3.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "BUCommonMacros.h"

@interface BUUserAgentHelper : NSObject
BU_SINGLETION(BUUserAgentHelper);

- (NSString *)userAgent;
@end

