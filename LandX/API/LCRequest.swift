//
//  LCRequest.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/20.
//

import Foundation
import Alamofire
import SwiftyJSON

/// Network Request Foundation
class LCRequest {
    
    let baseUrl = "https://api.nmb.best/api/"
    
    let domainGetCDNDomain = "getCDNPath"
    let domainGetForumList = "getForumList"
    let domainGetTimelineList = "getTimelineList"
    let domainShowForum = "showf"
    let domainTimeline = "timeline"
    let domainThread = "thread"
    let domainPo = "po"
    let domainRef = "ref"
    let domainFeed = "feed"
    let domainAddFeed = "addFeed"
    let domainDeleteFeed = "delFeed"
    
    let urlWebsiteNotice = "https://www.nmbxd.com/home/forum/doPostThread.html"
    let urlWebReply = "https://www.nmbxd.com/home/forum/doReplyThread.html"
    let urlWebRandomCover = "https://nmb.ovear.info/h.php"
    
    func getCDNPath() -> String {
        
        print("CoreRequest > Requesting CDN Path...")
        
        var default_cdn_url = "https://image.nmb.best/"
        var default_cdn_rate: Float = 0.0
        
        let semaphore = DispatchSemaphore.init(value: 0)
        let queue = DispatchQueue.init(label: "studio.tri.LandX.getCDNPath")
        
        queue.async {
            AF.request(self.baseUrl + self.domainGetCDNDomain).response { response in
                if(response.error != nil) {
                    print("CoreRequest > getCDNPath - Network Error")
                    default_cdn_url = "error#timeout"
                    semaphore.signal()
                    return
                }
                
                let j = JSON(response.result)
                for (_, subJ) in j {
                    let remote_domain_rate = subJ["rate"].float ?? 0.0
                    
                    if(remote_domain_rate > default_cdn_rate) {
                        let remote_domain = subJ["url"].string ?? ""
                        default_cdn_url = remote_domain
                        default_cdn_rate = remote_domain_rate
                        print("CoreRequest > Updated CDN path \(default_cdn_url) for rate \(default_cdn_rate)")
                    }
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return default_cdn_url
        
    }
    
    func getForumList() {
        
        
    }
    
    func getTimelineList() {
        
        
    }
    
    func showForum(fid: UInt, fPage: UInt) {
        
    }
    
    func showTimeline(thid: UInt, thpage: UInt) {
        
        
    }
    
    func showThread(tid: UInt, tpage: UInt) {
        
        
    }
    
    func showPo(tid: UInt, tpage: UInt) {
        
        
    }
    
    func showReference(tid: UInt) {
        
        
    }
    
    
    func sendPost() {
        
        
        
    }
    
    func sendReply() {
        
        
    }
    
    
    func showFeed() {
        
        
        
    }
    
    func addFeed() {
        
        
        
    }
    
    
    func deleteFeed() {
        
        
    }
    
    func getNotice() {
        
        
    }
    
    
    func getRandomCover() {
        
        
        
    }
}
