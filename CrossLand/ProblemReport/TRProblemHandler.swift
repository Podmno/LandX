//
//  TRProblemHandler.swift
//  LandX
//
//  Created by Ki MNO on 2023/12/25.
//

import UIKit

class TRProblemHandler: NSObject {

    
    func displayError(errorCode: UInt, viewController: UIViewController) {
        let alert_controller = UIAlertController(title: "无法连接到网络。", message: "错误代码 0301", preferredStyle: .alert)
        
 
        let action_view_cancel = UIAlertAction(title: "关闭", style: .default)
        let action_view_detail = UIAlertAction(title: "查看详情", style: .default, handler: {_ in
            
            let info_detail = TRVCProblemReport(nibName: "ProblemReporter", bundle: Bundle.main)
            info_detail.modalPresentationStyle = .overFullScreen
            info_detail.modalTransitionStyle = .crossDissolve
            // 修改状态栏的颜色
            info_detail.modalPresentationCapturesStatusBarAppearance = true
            viewController.present(info_detail, animated: true)
            
        })
        alert_controller.addAction(action_view_detail)
        alert_controller.addAction(action_view_cancel)
        
        
        
        alert_controller.view.tintColor = UIColor(named: "AccentColor")
        viewController.present(alert_controller, animated: true)
        
        
        
    }
    
}
