//
//  HMDBUImageLog.h
//  HeimdallrBU
//
//  Created by 谢俊逸 on 12/3/2018.
//

#import <Foundation/Foundation.h>
#import <mach/machine.h>
#import "HMDBUBinaryImage.h"


@interface HMDBUImageLog : NSObject
+ (NSString *)imageLogStringWithImageInfo:(HMDBUBinaryImage *)info;
+ (NSString *)binaryImagesLogStr;
+ (NSString *)binaryImagesLogStrWithValidImages:(NSMutableSet<NSString*>*)imageSet;
@end
