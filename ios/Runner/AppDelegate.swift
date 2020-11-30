import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.providerAPIKEY("AIzaSyBkobCPLPOvP_eNFEvbMO9vLQa8y6QBCss")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
