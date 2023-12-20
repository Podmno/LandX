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

    
    var forumViewer: TRForumViewerTable? = nil
    
    var forumListName: [String] = []
    var forumListID: [UInt] = []
    
    var timelineListName: [String] = []
    var timelineListID: [UInt] = []
    
    let sbPreferences = UIStoryboard(name: "TRPreference", bundle: Bundle.main)
    var vcPreferences: UIViewController? = nil
    
    @IBOutlet weak var btnForumList: UIButton!
    
    
    let API = LCAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let sb_trforum = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
        forumViewer = sb_trforum.instantiateViewController(withIdentifier: "TRForumTable") as? TRForumViewerTable

        self.mainViewContainer.alpha = 0.0
        
        UIView.animate(withDuration: 1.2, animations: {
            self.mainViewContainer.alpha = 1.0
        })
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
        
        self.refreshMainLand()
        
        self.loadForumListContent()
        
    }
    
    ///  主要函数 刷新主列表
    func refreshMainLand() {
        
        // 暂时的设计交给了 TRForumViewer 去自行处理，只需设定参数
        
    }
    
    
    func loadForumListContent() {
        
        let work_get_forumlist = DispatchQueue(label: "studio.tri.landX.mainLnadGetForumList")
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
            
            print(self.forumListName)
            print(self.forumListID)
            print(self.timelineListName)
            print(self.timelineListID)
            
            
            DispatchQueue.main.async {
                var menu_list: [UIAction] = []
                for f_list in self.forumListName {
                    
                    let ac = UIAction(title: f_list) {_ in
                        
                    }
                    
                    menu_list.append(ac)
                }
                
                let menu = UIMenu(title:"版面列表",children: menu_list)
                self.btnForumList.menu = menu
            }
        }
        
        
    }
    
    
    
    @IBAction func btnClickedPreferences(_ sender: Any) {
        vcPreferences = sbPreferences.instantiateInitialViewController()
        
        self.navigationController?.pushViewController(vcPreferences!, animated: true)
    }
    
    
}
