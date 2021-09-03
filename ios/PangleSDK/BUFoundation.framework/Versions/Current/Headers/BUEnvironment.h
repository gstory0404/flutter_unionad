//
//  BUEnvironment.h
//  BUFoundation
//
//  Created by bytedance on 2020/10/29.
//  Copyright © 2020 Union. All rights reserved.
//

#ifndef BUEnvironment_h
#define BUEnvironment_h

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

CTTelephonyNetworkInfo *BUDefaultTelephonyNetworkInfo(void);

@interface BUEnvironment : NSObject

@end

#endif /* BUEnvironment_h */
