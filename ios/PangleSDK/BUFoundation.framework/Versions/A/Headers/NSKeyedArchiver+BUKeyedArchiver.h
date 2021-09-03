//
//  NSKeyedArchiver+BUKeyedArchiver.h
//  BUFoundation
//
//  Created by Eason on 2021/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSKeyedArchiver (BUKeyedArchiver)
+ (NSData *)bu_archivedDataWithRootObject:(id)rootObject;
@end

NS_ASSUME_NONNULL_END
