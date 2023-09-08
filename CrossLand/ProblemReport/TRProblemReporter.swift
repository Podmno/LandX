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
        let action_view_detail = UIAlertAction(title: "查看详情", style: .cancel)
        
        
        alert_controller.addAction(action_view_cancel)
        //alert_controller.addAction(action_view_detail)
        
 
        parentController.present(alert_controller, animated: true)
        
    }
    
    
}
