//
//  BUZipArchive.h
//  BUZipArchive
//
//  Created by Sam Soffes on 7/21/10.
//  Copyright (c) Sam Soffes 2010-2015. All rights reserved.
//

#ifndef _BUZipArchive_H
#define _BUZipArchive_H

#import <Foundation/Foundation.h>
#import "BUZipCommon.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const BUZipArchiveErrorDomain;
typedef NS_ENUM(NSInteger, BUZipArchiveErrorCode) {
    BUZipArchiveErrorCodeFailedOpenZipFile      = -1,
    BUZipArchiveErrorCodeFailedOpenFileInZip    = -2,
    BUZipArchiveErrorCodeFileInfoNotLoadable    = -3,
    BUZipArchiveErrorCodeFileContentNotReadable = -4,
    BUZipArchiveErrorCodeFailedToWriteFile      = -5,
    BUZipArchiveErrorCodeInvalidArguments       = -6,
};

@protocol BUZipArchiveDelegate;

@interface BUZipArchive : NSObject


// Password check
+ (BOOL)isFilePasswordProtectedAtPath:(NSString *)path;
+ (BOOL)isPasswordValidForArchiveAtPath:(NSString *)path password:(NSString *)pw error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NOTHROW;

// Total payload size
+ (NSNumber *)payloadSizeForArchiveAtPath:(NSString *)path error:(NSError **)error;

// Unzip
+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination;
+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination delegate:(nullable id<BUZipArchiveDelegate>)delegate;

+ (BOOL)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
              overwrite:(BOOL)overwrite
               password:(nullable NSString *)password
                  error:(NSError * *)error;

+ (BOOL)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
              overwrite:(BOOL)overwrite
             needRename:(BOOL)needRename
               password:(nullable NSString *)password
                  error:(NSError * *)error
               delegate:(nullable id<BUZipArchiveDelegate>)delegate NS_REFINED_FOR_SWIFT;

+ (BOOL)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
     preserveAttributes:(BOOL)preserveAttributes
              overwrite:(BOOL)overwrite
               password:(nullable NSString *)password
                  error:(NSError * *)error
               delegate:(nullable id<BUZipArchiveDelegate>)delegate;

+ (BOOL)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
        progressHandler:(void (^_Nullable)(NSString *entry, bu_unz_file_info zipInfo, long entryNumber, long total))progressHandler
      completionHandler:(void (^_Nullable)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandler;

+ (BOOL)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
              overwrite:(BOOL)overwrite
               password:(nullable NSString *)password
        progressHandler:(void (^_Nullable)(NSString *entry, bu_unz_file_info zipInfo, long entryNumber, long total))progressHandler
      completionHandler:(void (^_Nullable)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandler;

+ (BOOL)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
     preserveAttributes:(BOOL)preserveAttributes
              overwrite:(BOOL)overwrite
             needRename:(BOOL)needRename
         nestedZipLevel:(NSInteger)nestedZipLevel
               password:(nullable NSString *)password
                  error:(NSError **)error
               delegate:(nullable id<BUZipArchiveDelegate>)delegate
        progressHandler:(void (^_Nullable)(NSString *entry, bu_unz_file_info zipInfo, long entryNumber, long total))progressHandler
      completionHandler:(void (^_Nullable)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandler;

// Zip
// default compression level is Z_DEFAULT_COMPRESSION (from "zlib.h")
// keepParentDirectory: if YES, then unzipping will give `directoryName/fileName`. If NO, then unzipping will just give `fileName`. Default is NO.

// without password
+ (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray<NSString *> *)paths;
+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath;

+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath keepParentDirectory:(BOOL)keepParentDirectory;

// with optional password, default encryption is AES
// don't use AES if you need compatibility with native macOS unzip and Archive Utility
+ (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray<NSString *> *)paths withPassword:(nullable NSString *)password;
+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath withPassword:(nullable NSString *)password;
+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath keepParentDirectory:(BOOL)keepParentDirectory withPassword:(nullable NSString *)password;
+ (BOOL)createZipFileAtPath:(NSString *)path
    withContentsOfDirectory:(NSString *)directoryPath
        keepParentDirectory:(BOOL)keepParentDirectory
               withPassword:(nullable NSString *)password
         andProgressHandler:(void(^ _Nullable)(NSUInteger entryNumber, NSUInteger total))progressHandler;
+ (BOOL)createZipFileAtPath:(NSString *)path
    withContentsOfDirectory:(NSString *)directoryPath
        keepParentDirectory:(BOOL)keepParentDirectory
           compressionLevel:(int)compressionLevel
                   password:(nullable NSString *)password
                        AES:(BOOL)aes
            progressHandler:(void(^ _Nullable)(NSUInteger entryNumber, NSUInteger total))progressHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;
- (BOOL)open;

/// write empty folder
- (BOOL)writeFolderAtPath:(NSString *)path withFolderName:(NSString *)folderName withPassword:(nullable NSString *)password;
/// write file
- (BOOL)writeFile:(NSString *)path withPassword:(nullable NSString *)password;
- (BOOL)writeFileAtPath:(NSString *)path withFileName:(nullable NSString *)fileName withPassword:(nullable NSString *)password;
- (BOOL)writeFileAtPath:(NSString *)path withFileName:(nullable NSString *)fileName compressionLevel:(int)compressionLevel password:(nullable NSString *)password AES:(BOOL)aes;
/// write data
- (BOOL)writeData:(NSData *)data filename:(nullable NSString *)filename withPassword:(nullable NSString *)password;
- (BOOL)writeData:(NSData *)data filename:(nullable NSString *)filename compressionLevel:(int)compressionLevel password:(nullable NSString *)password AES:(BOOL)aes;

- (BOOL)close;

@end

@protocol BUZipArchiveDelegate <NSObject>

@optional

- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(bu_unz_global_info)zipInfo;
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(bu_unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath;

- (BOOL)zipArchiveShouldUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(bu_unz_file_info)fileInfo;
- (void)zipArchiveWillUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(bu_unz_file_info)fileInfo;
- (void)zipArchiveDidUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(bu_unz_file_info)fileInfo;
- (void)zipArchiveDidUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath unzippedFilePath:(NSString *)unzippedFilePath;

- (void)zipArchiveProgressEvent:(unsigned long long)loaded total:(unsigned long long)total;

@end

NS_ASSUME_NONNULL_END

#endif /* _BUZipArchive_H */
