//
//  TRForumViewerManager.swift
//  LandX
//
//  Created by Ki MNO on 2023/9/8.
//

import UIKit

/// 设定 Forum View 的种类
enum TRFVType {
    
    /// 信息流界面 展示所有的串预览 并显示最近的几条回复
    case postFlow
    
    /// 点进串后的详细回复显示
    case detailView
    
    /// 仅展示串的引用信息
    case preview
    
}

/// 设定 ForumViewer 的展示配置
struct TRFVConfig {
    
    /// 设定 ForumViewer 的展示类别
    var viewerType: TRFVType = .postFlow
    
    /// 启用 URL 跳转功能
    var boolEnableURLTouch = false
    
    
    
}

/// Forum Viewer 管家：网络请求与界面种类
class TRFVController : NSObject {
    
    var viewerType: TRFVType = .postFlow
    
    var forumViewerTable: TRFVTable? = nil
    
    override init() {
        super.init()
        
        
    }
    
    /// 设定 Forum Viewer 配置信息
    func setupViewerInfo(config: TRFVConfig) {
        
    }
    
    /// 获取核心 ForumViewer
    func getCoreViewController() -> UIViewController? {
        
        return forumViewerTable
        
    }
    
}
