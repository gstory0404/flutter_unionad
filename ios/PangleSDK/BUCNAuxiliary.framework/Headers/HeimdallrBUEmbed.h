//
//  HeimdallrBUEmbed.h
//  HeimdallrBUEmbed
//
//  Created by xuminghao.eric on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import "HeimdallrBUEmbedConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeimdallrBUEmbed : NSObject

+ (void)registerSDKWithConfig:(HeimdallrBUEmbedConfig *)config;

+ (void)start;

@end

NS_ASSUME_NONNULL_END
