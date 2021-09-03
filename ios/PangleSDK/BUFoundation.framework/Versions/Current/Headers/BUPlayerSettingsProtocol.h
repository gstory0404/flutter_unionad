//
//  BUPlayerSettingsProtocol.h
//  BUFoundation
//
//  Created by bytedance on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUPlayerSettingsProtocol <NSObject>

@optional
+ (NSString *)videoCachePath;

+ (NSBundle *)playerResourceBundle;

+ (NSDictionary *)playerControlViewImages;

+ (NSDictionary *)playerControlLocalizedString;

+ (void)audioSessionSetting;
@end

NS_ASSUME_NONNULL_END
