import Flutter
import UIKit

public class SwiftAnimatedHiddenDrawerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "animated_hidden_drawer", binaryMessenger: registrar.messenger())
    let instance = SwiftAnimatedHiddenDrawerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
