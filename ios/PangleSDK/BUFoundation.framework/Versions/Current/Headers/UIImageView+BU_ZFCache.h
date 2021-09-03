//
//  UIImageView+ZFCache.h
//  Player
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

typedef void (^BU_ZFDownLoadDataCallBack)(NSData *data, NSError *error);
typedef void (^BU_ZFDownloadProgressBlock)(unsigned long long total, unsigned long long current);

@interface BU_ZFImageDownloader : NSObject<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;

@property (nonatomic, assign) unsigned long long totalLength;
@property (nonatomic, assign) unsigned long long currentLength;

@property (nonatomic, copy) BU_ZFDownloadProgressBlock progressBlock;
@property (nonatomic, copy) BU_ZFDownLoadDataCallBack callbackOnFinished;

- (void)startDownloadImageWithUrl:(NSString *)url
                         progress:(BU_ZFDownloadProgressBlock)progress
                         finished:(BU_ZFDownLoadDataCallBack)finished;

@end

typedef void (^BU_ZFImageBlock)(UIImage *image);

@interface UIImageView (BU_ZFCache)

/**
 *  Get/Set the callback block when download the image finished.
 *
 *  param image The image object from network or from disk.
 */
@property (nonatomic, copy) BU_ZFImageBlock bu_completion;

/**
 *  Image downloader
 */
@property (nonatomic, strong) BU_ZFImageDownloader *bu_imageDownloader;

/**
 *	Specify the URL to download images fails, the number of retries, the default is 2
 */
@property (nonatomic, assign) NSUInteger bu_attemptToReloadTimesForFailedURL;

/**
 *	Will automatically download to cutting for UIImageView size of image.The default value is NO.
 *  If set to YES, then the download after a successful store only after cutting the image
 */
@property (nonatomic, assign) BOOL bu_shouldAutoClipImageToViewSize;

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param placeholderImageName The image name to be set initially, until the image request finishes.
 */
- (void)setBUImageWithURLString:(NSString *)url placeholderImageName:(NSString *)placeholderImageName;

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param placeholderImage The image to be set initially, until the image request finishes.
 */
- (void)setBUImageWithURLString:(NSString *)url placeholder:(UIImage *)placeholderImage;

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholderImage    The image to be set initially, until the image request finishes.
 * @param completion     A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)setBUImageWithURLString:(NSString *)url
                  placeholder:(UIImage *)placeholderImage
                   completion:(void (^)(UIImage *image))completion;

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholderImageName    The image name to be set initially, until the image request finishes.
 * @param completion     A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)setBUImageWithURLString:(NSString *)url
         placeholderImageName:(NSString *)placeholderImageName
                   completion:(void (^)(UIImage *image))completion;
@end
