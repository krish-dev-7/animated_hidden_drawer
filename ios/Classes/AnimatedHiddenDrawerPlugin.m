#import "AnimatedHiddenDrawerPlugin.h"
#if __has_include(<animated_hidden_drawer/animated_hidden_drawer-Swift.h>)
#import <animated_hidden_drawer/animated_hidden_drawer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "animated_hidden_drawer-Swift.h"
#endif

@implementation AnimatedHiddenDrawerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnimatedHiddenDrawerPlugin registerWithRegistrar:registrar];
}
@end
