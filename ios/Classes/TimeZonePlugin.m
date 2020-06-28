#import "TimeZonePlugin.h"
#if __has_include(<time_zone/time_zone-Swift.h>)
#import <time_zone/time_zone-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "time_zone-Swift.h"
#endif

@implementation TimeZonePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTimeZonePlugin registerWithRegistrar:registrar];
}
@end
