//
//  NSObject+BUSafeKVO.h
//  BUFoundation
//
//  Created by Siwant on 2019/9/2.
//  Copyright © 2019 Union. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BUSafeKVO)

- (void)bu_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context;

- (void)bu_removeObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  context:(void *)context;

- (void)bu_removeObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath;

@end
