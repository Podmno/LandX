//
//  LCDefaults.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/29.
//

import Foundation

open class LCDefaults : NSObject {
    
    
    
    let manager = UserDefaults.standard
    
    func setFirstInitDisplayDataStatus(status: Bool) {
        manager.setValue(status, forKey: "landX.firstInitDisplayDataStatus")
        
    }
    
    func loadFirstInitDisplayDataStatus() -> Bool {
        return manager.bool(forKey: "landX.firstInitDisplayDataStatus")
    }
    
    func setUserCookieInfo() {
        
        
    }
    
    /// 全部恢复到默认配置
    func restoreDefaults() {
        manager.setValue(true, forKey: "landX.firstInitDisplayDataStatus")
    }
    
    
}
