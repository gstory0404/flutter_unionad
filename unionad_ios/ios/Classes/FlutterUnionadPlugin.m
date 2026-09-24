#import "FlutterUnionadPlugin.h"
#if __has_include(<unionad_ios/unionad_ios-Swift.h>)
#import <unionad_ios/unionad_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "unionad_ios-Swift.h"
#endif

@implementation FlutterUnionadPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUnionadPlugin registerWithRegistrar:registrar];
}
@end
