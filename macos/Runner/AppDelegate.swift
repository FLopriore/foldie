import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {

  override func applicationDidFinishLaunching(_ notification: Notification) {
      // Disable the full-screen button
      for window in NSApplication.shared.windows {
              if let zoomButton = window.standardWindowButton(NSWindow.ButtonType.zoomButton) {
                  zoomButton.isEnabled = false;
              }
      }
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
