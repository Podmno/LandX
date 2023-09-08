//
//  TRProblemReporter.swift
//  LandX
//
//  Created by Ki MNO on 2023/9/7.
//

import UIKit

open class TRProblemReporter : NSObject {
    
    public func showErrorMessage(parentController: UIViewController) {
        
        let alert_controller = UIAlertController(title: "发生未知错误，请稍后重试。", message: "错误代码 0401", preferredStyle: .alert)
        
 
        let action_view_cancel = UIAlertAction(title: "关闭", style: .default)
        let action_view_detail = UIAlertAction(title: "查看详情", style: .cancel, handler: {_ in
            
            let info_detail = TRVCProblemReport(nibName: "ProblemReporter", bundle: Bundle.main)
            info_detail.modalPresentationStyle = .overFullScreen
            info_detail.modalTransitionStyle = .crossDissolve
            // 修改状态栏的颜色
            info_detail.modalPresentationCapturesStatusBarAppearance = true
            parentController.present(info_detail, animated: true)
            
        })
        
        
        
        alert_controller.addAction(action_view_cancel)
        alert_controller.addAction(action_view_detail)
        
        
        parentController.present(alert_controller, animated: true)
        
    }
    
}


open class TRVCProblemReport : UIViewController {
    
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidAppear(_ animated: Bool) {

    }
    
    
    @IBAction func btnClickedReportProblem(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnClickedOK(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
