//
//  TRForumViewerTable.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/12.
//

import UIKit

class TRForumViewerTable : UIViewController {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    let mainTable = TRVCForumViewerTableMain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - TRForumViewerTable")
        //mainTable.loadData()
        mainTableView.delegate = mainTable
        mainTableView.dataSource = mainTable
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupRefreshUp()
        
        mainTableView.reloadData()
    }
    
    func setupRefreshUp() {
        
        let refresh = UIRefreshControl()
        mainTableView.addSubview(refresh)
        refresh.beginRefreshing()
        
        
    }

    
}


class TRVCForumViewerTableMain : NSObject ,UITableViewDelegate, UITableViewDataSource {
    

    //let threadXIBStoryboard = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return helperTableCell.cellCreateSwitch(text: "demo")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TRForumViewerCell
        
        cell.hideBtnGoThread()
        cell.hideImgView()
        cell.hideReplyLabel()
        //cell.lbSAGE.layer.transform = CATransform3DMakeScale(0.5, 1.0, 1.0)
        //layer.transform = CATransform3DMakeScale(0.8, 1.0, 1.0)
        //cell?.contentView.addSubview(threadStack[indexPath.row].view)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    
}



class TRForumViewerCell : UITableViewCell {
    
    var thread: LSThread = LSThread()
    
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbPO: UILabel!
    @IBOutlet weak var lbSAGE: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbNo: UILabel!
    @IBOutlet weak var btnGoThread: UIButton!
    @IBOutlet weak var lbMain: UILabel!
    @IBOutlet weak var lbReplyUser: UILabel!
    @IBOutlet weak var lbReplyContent: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var csBtnGoThreadHeight: NSLayoutConstraint!
    @IBOutlet weak var csImgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var csImgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var csLbReplyUserHeight: NSLayoutConstraint!
    @IBOutlet weak var csLbReplyContentHeight: NSLayoutConstraint!
    
    func hideBtnGoThread() {
        /*
        var originFrame = self.btnGoThread.frame
        originFrame.size.height = 0
        self.btnGoThread.frame = originFrame
         */

        self.csBtnGoThreadHeight.constant = 0.0
        self.btnGoThread.isHidden = true
        self.updateConstraints()
    }
    
    func hideImgView() {
        
        self.csImgViewWidth.constant = 0.0
        self.csImgViewHeight.constant = 0.0
        self.updateConstraints()
        
        
    }
    
    func hideReplyLabel() {
        
        csLbReplyUserHeight.constant = 0.0
        csLbReplyContentHeight.constant = 0.0
        lbReplyUser.isHidden = true
        lbReplyContent.isHidden = true
        self.updateConstraints()
        
    }
    
    func setupThread(thread: LSThread) {
        
        self.thread = thread
        
    }
    
    func updateCell() {
        
        lbUser.text = self.thread.threadUserHash
        
    }
    
    
}
