#import "MaskForCameraViewPlugin.h"
#if __has_include(<mask_for_camera_view/mask_for_camera_view-Swift.h>)
#import <mask_for_camera_view/mask_for_camera_view-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mask_for_camera_view-Swift.h"
#endif

@implementation MaskForCameraViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMaskForCameraViewPlugin registerWithRegistrar:registrar];
}
@end
