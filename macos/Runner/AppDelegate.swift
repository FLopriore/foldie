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
      
      // Run the adb command
      let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
      let channel = FlutterMethodChannel.init(name: "com.foldie/adb", binaryMessenger: controller.engine.binaryMessenger)
      channel.setMethodCallHandler({
        (_ call: FlutterMethodCall, _ result: FlutterResult) -> Void in
        if ("getAdbCommand" == call.method) {
            guard let args = call.arguments as? [String: String] else {return}
            let command = args["command"]!
            self.getAdbCommand(command: command, result: result);
        } else {
            result(FlutterMethodNotImplemented)
        }
      });
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
    
    private func getAdbCommand(command: String, result: FlutterResult) {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", "adb " + command]
        task.launchPath = "/bin/zsh"
        task.launch();
            
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        result(output);
    }
}
