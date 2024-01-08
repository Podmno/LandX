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

/// 设定 Forum View 要展示的内容类别
enum TRFVChannel {
    /// 展示 Forum 版面
    case forum
    
    /// 展示 Timeline 版面
    case timeline
    
    /// 展示 Thread 的详细内容
    case thread
}

/// 设定 ForumViewer 的展示配置
struct TRFVConfig {
    
    /// 设定 ForumViewer 的展示类别
    var viewerType: TRFVType = .postFlow
    
    /// 设定 Forum View 的展示内容类别
    var viewerChannel: TRFVChannel = .forum
    
    /// 设定 forumID / timelineID / threadID
    var defaultValueID: UInt = 4

    /// 设定 Page 号码
    var defaultValuePage: UInt = 1
    
    /// 启用 URL 跳转功能
    var boolEnableURLTouch = false
    
    /// 启用图片加载
    var boolEnablePictureLoad = false
    
    /// 启用时间格式转换。false 对应 X 岛展示事件，true 对应系统转换时间。
    var boolEnableTimeConvert = false
    
}

/// Forum Viewer 管家：网络请求与界面种类
class TRFVController : NSObject {
    
    let storyboardMain = UIStoryboard(name: "TRFV", bundle: Bundle.main)
    
    var viewerType: TRFVType = .postFlow
    
    var forumViewerTable: TRFVTable!
    var forumViewerConfig: TRFVConfig!
    
    override init() {
        super.init()
        
        forumViewerTable = storyboardMain.instantiateViewController(identifier: "TRForumTable") as? TRFVTable
        
        forumViewerConfig = TRFVConfig()
    }
    
    /// 设定 Forum Viewer 配置信息
    func setupViewerInfo(config: TRFVConfig) {
        self.forumViewerConfig = config
    }
    
    /// 获取核心 ForumViewer
    func getCoreViewController() -> TRFVTable {
        return forumViewerTable
        
    }
    
        
    
}
