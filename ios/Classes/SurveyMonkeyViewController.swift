import UIKit
import Flutter
import SurveyMonkeyiOSSDK

class SurveyMonkeyViewController: UIViewController, SMFeedbackDelegate {
    
    var surveyResult: FlutterResult?
    var surveyHash: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ตั้งพื้นหลังเป็น clear หรือสีเดียวกับแอป เพื่อไม่ให้ดูเป็นหน้าขาวค้าง
        self.view.backgroundColor = .clear 
        
        guard let feedbackController = SMFeedbackViewController(survey: surveyHash) else {
            surveyResult?(FlutterError(code: "INIT_FAILED", message: "Failed to create SurveyMonkey VC", details: nil))
            self.dismiss(animated: true, completion: nil) // เปลี่ยนจาก pop เป็น dismiss
            return
        }

        print("feedbackController \(feedbackController)")
        
        feedbackController.delegate = self
        // แสดงผล
        feedbackController.present(from: self, animated: true, completion: nil)
    }
    
    // MARK: - SMFeedbackDelegate
    func respondentDidEndSurvey(_ respondent: SMRespondent!, error: Error!) {
        // ส่งผลลัพธ์กลับไปที่ Flutter
        if let _ = respondent {
            surveyResult?("COMPLETED")
        } else {
            surveyResult?("INCOMPLETED")
        }
        
        // จุดสำคัญ: ต้องใช้ dismiss เพื่อปิด Modal ที่เรา present ขึ้นมา
        self.dismiss(animated: true, completion: nil)
    }
    
    func surveyDidFailToLoadWithError(_ error: Error!) {
        surveyResult?(FlutterError(code: "LOAD_ERROR", message: error.localizedDescription, details: nil))
        // จุดสำคัญ: ใช้ dismiss เพื่อปิดหน้าจอที่โหลดไม่ได้
        self.dismiss(animated: true, completion: nil)
    }
}