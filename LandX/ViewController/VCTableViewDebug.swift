//
//  VCTableViewDebug.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/12.
//

import UIKit

class VCTableViewDebug : UIViewController {
    
    var forumViewer: TRForumViewerTable? = nil
    
    
    @IBOutlet weak var btnClickedReturn: UIButton!
    @IBOutlet weak var containerMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sb_trforum = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
        forumViewer = sb_trforum.instantiateViewController(withIdentifier: "TRForumTable") as? TRForumViewerTable
        // 重要： 设置 Frame 后才能够正常滚动
        // 设定为 view.frame 占满空间 而 container 的 frame 会空出一部分空间
        forumViewer!.view.frame = view.frame
        //forumViewer!.view.bounds = CGRectMake(0, 0, containerMain.bounds.size.width, containerMain.bounds.size.height)
        containerMain.addSubview((forumViewer?.view)!)
        // 添加 didMove 响应滚动操作
        forumViewer?.didMove(toParent: self)
        
    }
    
    @IBAction func btnClickedReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
