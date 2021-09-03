//
//  HeimdallrBUEmbedConfig.h
//  HeimdallrBUEmbed
//
//  Created by xuminghao.eric on 2020/12/14.
//

#import <Foundation/Foundation.h>
#import "HMDBUEmbedAddressRange.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeimdallrBUEmbedConfig : NSObject

@property (nonatomic, copy) NSString *sdkID;

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *filter;

@property (nonatomic, strong) NSArray<HMDBUEmbedAddressRange *> *addressRanges;

@end

NS_ASSUME_NONNULL_END
