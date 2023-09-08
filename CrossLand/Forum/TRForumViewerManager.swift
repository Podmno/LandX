//
//  TRForumViewerManager.swift
//  LandX
//
//  Created by Ki MNO on 2023/9/8.
//

import UIKit

/// 设定 Forum View 的种类
enum TRForumViewerType {
    
    /// 信息流界面 展示所有的串预览 并显示最近的几条回复
    case postFlow
    
    /// 点进串后的详细回复显示
    case detailView
    
    /// 仅展示串的引用信息
    case preview
    
}

class TRForumViewerManager : NSObject {
    
    var viewerType: TRForumViewerType = .postFlow
    
    var forumViewerTable: TRForumViewerTable? = nil
    
    /// 设定 Forum Viewer 的显示种类
    func setupViewerType(viewerType: TRForumViewerType) {
        self.viewerType = viewerType
    }
    
    func getCoreView() {
        
        
    }
    
}
