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
    
    let sbPreferences = UIStoryboard(name: "TRPreference", bundle: Bundle.main)
    var vcPreferences: UIViewController? = nil
    

    
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
        

        
    }
    

    
    
    @IBAction func btnClickedForumList(_ sender: Any) {
        let err = TRProblemReporter()
        err.showErrorMessage(parentController: self)
    }
    
    @IBAction func btnClickedPreferences(_ sender: Any) {
        vcPreferences = sbPreferences.instantiateInitialViewController()
        
        self.navigationController?.pushViewController(vcPreferences!, animated: true)
    }
    
    
}
