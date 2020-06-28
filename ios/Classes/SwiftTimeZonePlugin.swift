import Flutter
import UIKit

public class SwiftTimeZonePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "time_zone", binaryMessenger: registrar.messenger())
        let instance = SwiftTimeZonePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getTimeZoneData" {
            let dict = getTimeZoneData()
            result(dict)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getTimeZoneData() -> [String: Any] {
        let zone = TimeZone.autoupdatingCurrent
        let abbreviation = zone.abbreviation()
        var offset = Int(abbreviation?.components(separatedBy: "GMT").last ?? "0") ?? 0
        
        if zone.isDaylightSavingTime() {
            offset -= Int(zone.daylightSavingTimeOffset() / 3600)
        }
        
        let dict: [String: Any] = ["id": zone.identifier, "offset": offset]
        return dict
    }
}
