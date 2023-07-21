//
//  LCThread.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/21.
//

import Foundation
import SwiftyJSON


class LSForumList : NSObject {
    
    public var forumListID: UInt = 0
    public var forumListSort: UInt = 0
    public var forumListName: String = ""
    public var forumStatus: String = ""
    public var forums: Array<LSForum> = []
    
    
}

class LSForum : NSObject {
    
    public var forumID: UInt = 0
    public var forumGroup: UInt = 0
    public var forumSort: UInt = 0
    public var forumName: String = ""
    public var forumShowName: String = ""
    public var forumMsg: String = ""
    public var forumInterval: UInt = 0
    public var forumSafeMode: UInt = 0
    public var forumAutoDelete: UInt = 0
    public var forumThreadCount: UInt = 0
    public var forumPermissionLevel: UInt = 0
    public var forumFuseID: UInt = 0
    public var forumCreatedAt: String = ""
    public var forumUpdatedAt: String = ""
    public var forumStatus: String = ""
    
}

class LSTimelineList : NSObject {
    
    public var timelineList: Array<LSTimeline> = []
    
}

class LSTimeline : NSObject {
    
    public var timelineID: UInt = 0
    public var timelineName: String = ""
    public var timelineDisplayName: String = ""
    public var timelineNotice: String = ""
    public var timelineMaxpage: UInt = 0
    
    
}


class LSThread : NSObject {
    
    public var threadID: UInt = 0
    public var threadForumID: UInt = 0
    public var threadReplyCount: UInt = 0
    
    public var threadImg: String = ""
    public var threadExt: String = ""
    public var threadDate: String = ""
    public var threadUserHash: String = ""
    public var threadName: String = ""
    public var threadTitle: String = ""
    public var threadContent: String = ""
    public var threadSage: UInt = 0
    public var threadAdmin: UInt = 0
    public var threadHide: UInt = 0
    public var threadReplies: Array<LSThread> = []
    public var threadRemainReplies: UInt = 0
    

    
}

class LSPost: NSObject {
    
    public var postName: String = ""
    public var postTitle: String = ""
    public var postContent: String = ""
    public var postForumID: UInt = 0
    public var postImage: Data = Data()
    public var postWater: Bool = false
    
}


class LSOfficialNotice : NSObject {
    
    
    public var noticeContent: String = ""
    public var noticeDate: UInt = 0
    public var noticeEnabled: Bool = false
    
}
