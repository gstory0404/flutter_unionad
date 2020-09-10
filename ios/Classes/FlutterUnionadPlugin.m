#import "FlutterUnionadPlugin.h"
#if __has_include(<flutter_unionad/flutter_unionad-Swift.h>)
#import <flutter_unionad/flutter_unionad-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_unionad-Swift.h"
#endif

@implementation FlutterUnionadPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUnionadPlugin registerWithRegistrar:registrar];
}
@end

