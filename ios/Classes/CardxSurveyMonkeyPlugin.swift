import Flutter
import UIKit
import SurveyMonkeyiOSSDK

public class CardxSurveyMonkeyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cardx_survey_monkey", binaryMessenger: registrar.messenger())
    let instance = CardxSurveyMonkeyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "showSurvey" {
      guard let args = call.arguments as? [String: Any],
            let collectorHash = args["collectorHash"] as? String else {
        result(FlutterError(code: "INVALID_ARGS", message: "Collector hash missing", details: nil))
        return
      }

      // 1. หา Top ViewController แทนการใช้ Root
      guard let topVC = getTopViewController() else {
        result(FlutterError(code: "UI_ERROR", message: "Cannot find active view controller", details: nil))
        return
      }

      // 2. ใช้ Modal Presentation เพื่อไม่ต้องยุ่งกับ NavigationController
      let surveyVC = SurveyMonkeyViewController()
      surveyVC.surveyHash = collectorHash
      surveyVC.surveyResult = result
      
      // ตั้งค่า Presentation style ให้สวยงาม (แบบเต็มหน้าจอ)
      surveyVC.modalPresentationStyle = .overCurrentContext
      topVC.present(surveyVC, animated: true, completion: nil)
      
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

    // ฟังก์ชันหาหน้าจอที่กำลังแสดงผลอยู่ตอนนี้
  private func getTopViewController() -> UIViewController? {
    var topController = UIApplication.shared.keyWindow?.rootViewController
    while let presentedViewController = topController?.presentedViewController {
      topController = presentedViewController
    }
    return topController
  }
}
