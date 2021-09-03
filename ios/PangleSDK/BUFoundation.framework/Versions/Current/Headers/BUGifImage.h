//
//  BUGifImage.h
//  BUGif
//
//  Created by Johnil on 14-3-6.
//  Copyright (c) 2014年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUGifImage : UIImage

@property (nonatomic,assign) NSInteger currentPlayIndex;
@property (nonatomic,strong) NSData *data;

+ (instancetype)gifWithData:(NSData *)data;

- (UIImage *)nextImage;
- (NSInteger)count;
- (CGFloat)frameDuration;
- (void)resumeIndex;
/// 是否还有下一桢
- (BOOL) hasNextImage;

@end
