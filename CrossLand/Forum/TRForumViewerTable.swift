//
//  TRForumViewerTable.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/12.
//

import UIKit

/// 核心 FormView Tabe View
class TRForumViewerTable : UIViewController {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    let mainTable = TRVCForumViewerTableMain()
    let mainRefresh = UIRefreshControl()
    
    var threadListData: [LSThread] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mainTable.loadData()
        mainTableView.delegate = mainTable
        mainTableView.dataSource = mainTable
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupRefreshUp()
        

        mainTableView.reloadData()
        
        loadForumData()
    }
    
    func setupRefreshUp() {
        

        mainTableView.addSubview(mainRefresh)
        mainRefresh.beginRefreshing()

        mainTableView.scrollsToTop = true
        
        mainRefresh.endRefreshing()
    }
    
    func setupTableForum() {
        
        mainTable.threadDisplayQueue.append(contentsOf: threadListData)
        
        mainTableView.reloadData()
        
        
    }
    
    func loadForumData() {
        
        let queue = DispatchQueue.init(label: "landX.networkRequest.mainData")
        
        queue.async {
            
            let API = LCAPI()
            
            let r_list = API.getForum(forumID: 4, forumPage: 1)
            
            // Append Forum Data
            self.threadListData.append(contentsOf: r_list)
            
            DispatchQueue.main.async {
                self.setupTableForum()
            }
            
        }
    }

}


class TRVCForumViewerTableMain : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    // TableViewCell Stack
    var tableViewCell : [UITableViewCell] = []

    //let threadXIBStoryboard = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
    public var threadDisplayQueue: [LSThread] = []

    override init() {
        super.init()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return threadDisplayQueue.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return helperTableCell.cellCreateSwitch(text: "demo")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TRForumViewerCell
        
        cell.hideBtnGoThread()
        cell.hideImageView()
        cell.hideReplyLabel()
        
        // FIXME: 在 TableView 载入之前初始化完成富文本转换任务
        cell.setupThread(thread: threadDisplayQueue[indexPath.row])
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // TableView 动画
        let cell = cell
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 0.7, 1))
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        cell.layer.add(animation, forKey: "transform")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Scrool 处理
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 完全松开
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
    
    /// 隐藏引用条按钮
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
    
    /// 隐藏图片显示
    func hideImageView() {
        
        self.csImgViewWidth.constant = 0.0
        self.csImgViewHeight.constant = 0.0
        self.updateConstraints()
        
        
    }
    
    /// 隐藏回复数
    func hideReplyLabel() {
        
        csLbReplyUserHeight.constant = 0.0
        csLbReplyContentHeight.constant = 0.0
        lbReplyUser.isHidden = true
        lbReplyContent.isHidden = true
        self.updateConstraints()
        
    }
    
    /// 填充 Thread 信息
    func setupThread(thread: LSThread) {
        
        self.thread = thread
        
        updateCell()
    }
    
    /// 用 Thread 信息更新 Cell
    func updateCell() {
        
        lbUser.text = self.thread.threadUserHash
        
        if(self.thread.threadSage != 0) {
            self.lbSAGE.isHidden = false
        } else {
            self.lbSAGE.isHidden = true
        }
        
        lbNo.text = "No.\(self.thread.threadID)"
        
        lbTime.text = self.thread.threadDate
        
        //lbMain.text = self.thread.threadContent
        
        // 去除 HTML a 标签，优化显示效果
        lbMain.attributedText = self.thread.threadContentAttributedString

        
        
        // 目前暂时禁用部分功能
        hideImageView()
        hideReplyLabel()
        hideBtnGoThread()
    }
    
    
}


/*
let html_a_label_pattern = "<a+.*?>([\\s\\S]*?)|</a*?>"
let regex = try! NSRegularExpression(pattern: html_a_label_pattern)
let th_replace_result = regex.stringByReplacingMatches(in: self.thread.threadContent, range: NSRange(location: 0, length: self.thread.threadContent.count), withTemplate: "")
let data = th_replace_result.data(using: .unicode)
                              
                              
let systemFont = UIFont.systemFont(ofSize: 16)
let attr = [NSAttributedString.Key.font: systemFont]

if let attributedString = try? NSMutableAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
    attributedString.addAttributes(attr, range: NSRange(location: 0, length: attributedString.length))
    lbMain.attributedText = attributedString
}
*/
