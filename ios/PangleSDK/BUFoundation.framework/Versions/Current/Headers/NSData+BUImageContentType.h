/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Fabrice Aneche
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "BU_SDWebImageCompat.h"

/**
 You can use switch case like normal enum. It's also recommended to add a default case. You should not assume anything about the raw value.
 For custom coder plugin, it can also extern the enum for supported format. See `SDImageCoder` for more detailed information.
 */
typedef NSInteger BU_SDImageFormat NS_TYPED_EXTENSIBLE_ENUM;
static const BU_SDImageFormat BU_SDImageFormatUndefined = -1;
static const BU_SDImageFormat BU_SDImageFormatJPEG      = 0;
static const BU_SDImageFormat BU_SDImageFormatPNG       = 1;
static const BU_SDImageFormat BU_SDImageFormatGIF       = 2;
static const BU_SDImageFormat BU_SDImageFormatTIFF      = 3;
static const BU_SDImageFormat BU_SDImageFormatWebP      = 4;
static const BU_SDImageFormat BU_SDImageFormatHEIC      = 5;
static const BU_SDImageFormat BU_SDImageFormatHEIF      = 6;
static const BU_SDImageFormat BU_SDImageFormatPDF       = 7;
static const BU_SDImageFormat BU_SDImageFormatSVG       = 8;

/**
 NSData category about the image content type and UTI.
 */
@interface NSData (BU_ImageContentType)

/**
 *  Return image format
 *
 *  @param data the input image data
 *
 *  @return the image format as `BU_SDImageFormat` (enum)
 */
+ (BU_SDImageFormat)sdBu_imageFormatForImageData:(nullable NSData *)data;

/**
 *  Convert BU_SDImageFormat to UTType
 *
 *  @param format Format as BU_SDImageFormat
 *  @return The UTType as CFStringRef
 */
+ (nonnull CFStringRef)sdBu_UTTypeFromImageFormat:(BU_SDImageFormat)format CF_RETURNS_NOT_RETAINED NS_SWIFT_NAME(sdBu_UTType(from:));

/**
 *  Convert UTTyppe to BU_SDImageFormat
 *
 *  @param uttype The UTType as CFStringRef
 *  @return The Format as BU_SDImageFormat
 */
+ (BU_SDImageFormat)sdBu_imageFormatFromUTType:(nonnull CFStringRef)uttype;

@end
