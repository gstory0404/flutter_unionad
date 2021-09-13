//
//  NSObject+BUUtils.h
//  BUFoundation
//
//  Created by wangyanlin on 2020/12/7.
//  Copyright © 2020 Union. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BUUtils)

+ (NSString *)bu_convertToStringWithOrignalObj:(id)obj;

- (NSDictionary *)bu_dictAfterFormatWithOriginDict:(NSDictionary *)originDict;
+ (NSArray *)bu_aryAfterFormatWithOriginAry:(NSArray *)originAry;

@end

NS_ASSUME_NONNULL_END
