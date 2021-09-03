//
//  BUImage.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUImage : NSObject <NSCoding>

// image address URL
@property (nonatomic, copy) NSString *imageURL;

// image key
@property (nonatomic, copy) NSString *image_key;


// image width
@property (nonatomic, assign) float width;

// image height
@property (nonatomic, assign) float height;

// stream ad image druation

@property (nonatomic, assign) float duration;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

- (NSDictionary *)dictionaryValue;

@end

