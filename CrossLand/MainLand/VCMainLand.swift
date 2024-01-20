//
//  VCMainLand.swift
//  LandX
//
//  Created by Ki MNO on 2023/9/8.
//

import UIKit

class VCMainLand : UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var lbLargeTitle: UILabel!
    @IBOutlet weak var mainViewContainer: UIView!
    @IBOutlet weak var btnWritePost: UIButton!
    @IBOutlet weak var btnForumList: UIButton!
    @IBOutlet weak var artNetworkError: UIImageView!
    
    var forumViewer: TRFVTable? = nil
    
    var forumListName: [String] = []
    var forumListID: [UInt] = []
    
    var timelineListName: [String] = []
    var timelineListID: [UInt] = []
    
    let sbPreferences = UIStoryboard(name: "TRPreference", bundle: Bundle.main)
    var vcPreferences: UIViewController? = nil
    
    
    // TODO: 在加载完成之后销毁 ViewController
    var vcLoadingAnimationView = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
    var vcWritePost: UIViewController? = nil
    var vcWhatsNew: VCWhatsNew? = nil
    
    // 防止 viewDidLoad 方法中重复加载
    var boolForumListLoaded: Bool = false
    
    var subThread: VCSubLand? = nil
    
    
    var postWindow: UIWindow? = nil
    
    let API = LCAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         
         loadingAnimationView = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
         loadingAnimationView!.view.frame = CGRect(x: 0, y: 0, width: bnd.width, height: 40)
         */

        vcLoadingAnimationView.view.frame = mainViewContainer.bounds
        self.mainViewContainer.addSubview(vcLoadingAnimationView.view)
        
        
        let sb_trforum = UIStoryboard(name: "TRFV", bundle: Bundle.main)
        forumViewer = sb_trforum.instantiateViewController(withIdentifier: "TRForumTable") as? TRFVTable
        forumViewer!.view.isHidden = true
        
        vcWritePost = VCWritePost(nibName: "VCWritePost", bundle: Bundle.main)

        
        vcWhatsNew = VCWhatsNew(nibName: "VCWhatsNew", bundle: Bundle.main)
 
        
        self.mainViewContainer.alpha = 0.0
        
        UIView.animate(withDuration: 1.2, animations: {
            self.mainViewContainer.alpha = 1.0
        })
        
        
        if(!boolForumListLoaded) {
            self.forumDataDisplayPre()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(forumJumpSubLand), name: NSNotification.Name("LandXForumJump"), object: nil)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if(self == navigationController?.viewControllers[0]) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // 重要： 设置 Frame 后才能够正常滚动
        // 设定为 view.frame 占满空间 而 container 的 frame 会空出一部分空间
        forumViewer!.view.frame = mainViewContainer.bounds
        
        //forumViewer!.view.bounds = CGRectMake(0, 0, containerMain.bounds.size.width, containerMain.bounds.size.height)
        mainViewContainer.addSubview((forumViewer?.view)!)
        // 添加 didMove 响应滚动操作
        forumViewer?.didMove(toParent: self)
        
        //self.refreshMainLand()
        
    }
    
    @objc func forumJumpSubLand(notification: NSNotification) {
        print("MainLand receive notification! ")
        let data_result = notification.object as! Dictionary<String, Any>
        let fid = data_result["id"] as! UInt
        
        print("MainLand > GO Thread ID: \(fid)")
        
        subThread = VCSubLand(nibName: "VCSubLand", bundle: Bundle.main)
        subThread?.setSubLandThreadID(tid: fid)
        self.navigationController?.pushViewController(subThread!, animated: true)
    }

    
    /// 预准备：检查网络情况等
    func forumDataDisplayPre() {
        
        // 检查网络连接
        let check_network = DispatchQueue(label: "studio.tri.landx.mainLandCheckNetwork")
        check_network.async {
            let reply = self.API.checkNetworkStatus()
            
            if(reply != LCAPINetworkStatus.success) {
                DispatchQueue.main.async {
                    let handler = TRProblemHandler()
                    handler.displayError(errorCode: 100001, viewController: self)
                    
                    // 网络错误展示
                    self.artNetworkError.isHidden = false
                   
                    self.mainViewContainer.isHidden = true
                    return
                }
            } else {
                // 检查网络成功 > 才进行数据内容载入
                
                self.forumDataDisplayNetwork()
            }
            
        }
        
        
    }
    
    /// 请求网络信息
    func forumDataDisplayNetwork() {
        
        let work_get_forumlist = DispatchQueue(label: "studio.tri.landX.mainLandGetForumList")
        work_get_forumlist.async {
            
            print("MainLand > - Network - Get Forum & Timeline List...")
            
            let reply_forum_list = self.API.getTotalForumList()
            let reply_timeline_list = self.API.getTimelineList()
            
            for fl_data in reply_forum_list {
                
                for f_data in fl_data.forums {
                    
                    self.forumListName.append(f_data.forumName)
                    self.forumListID.append(f_data.forumID)
                    
                }
                
            }
            
            for t_data in reply_timeline_list.timelineList {
                
                self.timelineListName.append(t_data.timelineDisplayName)
                self.timelineListID.append(t_data.timelineID)
                
            }
            

            DispatchQueue.main.async {
                self.forumViewer!.view.isHidden = false
                
                
                var menu_list: [UIAction] = []
                for f_list in self.forumListName {
                    
                    let ac = UIAction(title: f_list) {handler in
                        print(handler.title)
                    }
                    
                    
                    menu_list.append(ac)
                }
                
                let menu = UIMenu(title:"版面列表",children: menu_list)
                if #available(macCatalyst 14.0, *) {
                    self.btnForumList.menu = menu
                } else {
                    // Fallback on earlier versions
                }
                self.boolForumListLoaded = true
            }
        }
        
        
    }
    
    // MARK: UI Actions
    
    
    @IBAction func btnClickedPreferences(_ sender: Any) {
        vcPreferences = sbPreferences.instantiateInitialViewController()
        
        self.navigationController?.pushViewController(vcPreferences!, animated: true)
    }
    
    @IBAction func btnClickedPost(_ sender: Any) {
        vcWritePost?.modalPresentationStyle = .formSheet
        vcWritePost?.popoverPresentationController?.sourceView = self.btnWritePost
        vcWritePost?.popoverPresentationController?.sourceRect = self.btnWritePost.bounds
 
        self.present(vcWritePost!, animated: true)


        //let scenes = UIApplication.shared.connectedScenes
        //let windowScene = scenes.first as? UIWindowScene
        //let window = windowScene?.windows.first
        //vcWritePost!.view.frame = CGRect(x:  10, y: 10, width: self.view.frame.size.width - 20, height: 300)
        //window?.addSubview(vcWritePost!.view)
    }
    
}
