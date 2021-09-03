//
//  NSUserDefaults+BUCrypt.h
//  BUFoundation
//
//  Created by Willie on 2020/9/11.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (BUCrypt)

- (void)setValue:(nullable id)value
          forKey:(NSString *)key
           crypt:(BOOL)crypt
           error:(NSError **)error;

- (nullable id)valueForKey:(NSString *)defaultName
                     crypt:(BOOL)crypt
                     error:(NSError **)error;

- (void)removeObjectForKey:(NSString *)defaultName
                     crypt:(BOOL)crypt
                     error:(NSError **)error;

- (void)bu_synchronize;

@end

NS_ASSUME_NONNULL_END
