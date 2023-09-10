//
//  LCAPI.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/20.
//

import Foundation

open class LCAPI : NSObject {
    
    let globalStorage = LCStorage.shared
    
    let request = LCRequest()
    
    /// 启用 LCStorage 的临时资料读取
    public var tempStorageEnabled = true
    
    /// 启用 LCStorage 的缓存更新策略
    public var tempStorageRefresh = true
    
    /// 获取 Forum List
    public func getForumList() -> LSForumList {
        
        let forumlist_data = request.getForumList()
        let forumlist_list = LSForumList()
        forumlist_list.loadFromJSON(json: forumlist_data)
        return forumlist_list
        
    }
    
    /// 获取 Timeline List
    public func getTimelineList() -> LSTimelineList {
        
        let timeline_data = request.getTimelineList()
        let timeline_list = LSTimelineList()
        timeline_list.loadFromJSON(json: timeline_data)
        return timeline_list
        
    }
    
    /// 获取 Thread 信息
    public func getThread(threadID: UInt, threadPage: UInt) -> LSThread {
        
        let thread_data = request.showThread(tid: threadID, tpage: threadPage)
        let th = LSThread()
        th.loadFromJSON(json: thread_data)
        return th
        
    }
    
    /// 获取指定 Forum 的回复
    public func getForum(forumID: UInt, forumPage: UInt) -> [LSThread] {
        var replies: [LSThread] = []
        let repo_json = request.showForum(fid: forumID, fPage: forumPage)
        
        for (_, single_repo) in repo_json {
            
            let rp = LSThread()
            rp.loadFromJSON(json: single_repo)
            replies.append(rp)
        }

        return replies
    }
    
    /// 获取指定 Timeline 的内容
    public func getTimeline(timelineID: UInt, timelinePage: UInt) -> LSTimeline {
        
        let timeline_json = request.showTimeline(thid: timelineID, thpage: timelinePage)
        let timeline_data = LSTimeline()
        timeline_data.loadFromJSON(json: timeline_json)
        return timeline_data
        
    }
    
    /// 更新 ForumList 与 TimelineList 的本地存储
    public func updateForumsStorage() {
        
        
    }
    
    /// 更新 CDN 网络路径（图片保存）
    public func updateCDNNetworkPath() {
        
        
        
    }
    
    
}
