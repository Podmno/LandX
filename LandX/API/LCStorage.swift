//
//  LCStorage.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/28.
//

import Foundation


open class LCStorage : NSObject {
    
    /// 全局共享的存储器资源
    static let shared = LCStorage()
    
    /// CDN 镜像 URL
    var cdnUrl: String = ""
    
    public func globalSaveForumListData() {
        
        
        
    }
    
    public func globalSaveCDNImgageURL(cdnUrl: String) {
        
        print("GlobalConfig > CDN Image Url Updated \(cdnUrl)")
        self.cdnUrl = cdnUrl
        
    }
    
    public func getForumNameByID(fid: UInt) {
        
        
        
    }
    
    public func getTimlineNameByID(tid: UInt) {
        
        
        
    }
    
}
