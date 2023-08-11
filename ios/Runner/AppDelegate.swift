import UIKit
import workmanager
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      // In AppDelegate.application method
      GeneratedPluginRegistrant.register(with: self)
      // In AppDelegate.application method
      WorkmanagerPlugin.registerTask(withIdentifier: "task-identifier")
       UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
  }
}
