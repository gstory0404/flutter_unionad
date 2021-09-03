//
//  BUPersonalizationPrompts.h
//  BUAdSDK
//
//  Created by bytedance on 2020/11/10.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface BUPersonalizationPrompts : NSObject <NSCoding>
/// personalization prompts's name
@property (nonatomic, copy) NSString *personalizationName;
/// personalization prompts's url
@property (nonatomic, copy) NSString *personalizationUrl;
/// personalization prompts valid or not
- (BOOL)validPersonalPrompts;
@end

NS_ASSUME_NONNULL_END
