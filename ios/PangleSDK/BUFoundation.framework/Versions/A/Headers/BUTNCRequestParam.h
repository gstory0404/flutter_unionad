//
// Created by bytedance on 2020/12/16.
//

#import <Foundation/Foundation.h>
#import "BUCommonMacros.h"

@interface BUTNCRequestParam : NSObject <BUDictionarify>

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *deviceDid;

@property (nonatomic, copy) NSString *ssAppID;

@end