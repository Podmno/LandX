//
//  TRForumViewerTable.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/12.
//

import UIKit

/// 核心 FormView Tabe View
class TRFVTable : UIViewController {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    let mainTable = TRVCFVTableMain()
    
    var loadingAnimationView: TRLoading? = nil

    var threadListData: [LSThread] = []
    
    var dataConfig: TRFVConfig = TRFVConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.config = dataConfig
        mainTableView.delegate = mainTable
        mainTableView.dataSource = mainTable
        mainTableView.backgroundView = nil
        mainTableView.backgroundView = UIView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.reloadData()
        
        initForumDataLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    

    public func setupConfig(config: TRFVConfig) {
        dataConfig = config
    }

    
    func setupTableForum() {
        print("< remove")
        
        mainTable.threadDisplayQueue.append(contentsOf: threadListData)

        mainTableView.reloadData()
        mainTableView.layoutIfNeeded()
        
        var inset = mainTableView.contentInset
        inset.top -= 80
        self.mainTableView.contentInset = inset
        inset.top += 80
        self.mainTableView.contentInset = inset
        //mainTableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .top, animated: false)
        mainTableView.scrollRectToVisible(CGRectMake(0, 80, 0, 80), animated: true)
        
        
    }
    
    func initForumDataLoad() {
        self.setupTableForum()
        self.mainTable.loadNetworkData()
    }
    


}


class TRVCFVTableMain : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    let vcLoadingFooter = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
    let vcLoadingHeader = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
    
    var viewHeader: UIView? = nil
    
    var tableViewSelf: UITableView? = nil
    
    var scroolViewSelf: UIScrollView? = nil
    
    /// 配置：0：展示 Forum / 1：展示 Timeline / 2：展示 Thread
    public var config = TRFVConfig()
    
    /// 是否允许页面刷新（用于防止重复刷新）
    var currentStatusOnRefreshing = true
    
    /// 当前最下方加载的页面标记
    var currentStatusNowPage: UInt = 0
    
    // TableViewCell Stack
    var tableViewCell : [UITableViewCell] = []

    //let threadXIBStoryboard = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
    public var threadDisplayQueue: [LSThread] = []

    override init() {
        super.init()

        
    }
    
    func loadNetworkData() {
        
        self.currentStatusOnRefreshing = true
        self.currentStatusNowPage += 1
        let queue = DispatchQueue.init(label: "landX.networkRequest.mainData")
        
        queue.async {
            
            let API = LCAPI()
            
            if (self.config.viewerChannel == .forum) {
                let r_list = API.getForum(forumID: 4, forumPage: self.currentStatusNowPage)
                
                // Append Forum Data
                self.threadDisplayQueue.append(contentsOf: r_list)
            }
            
            
            
            DispatchQueue.main.async {
                //self.tableViewSelf?.reloadData()
                
                self.tableViewSelf?.reloadSections(IndexSet(integer: 0), with: .fade)
                
                self.currentStatusOnRefreshing = false
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        tableViewSelf = tableView
        
        
        return threadDisplayQueue.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemBackground
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select indexPath \(indexPath.row)")
        
        let id_data = threadDisplayQueue[indexPath.row].threadID
        let f_data = threadDisplayQueue[indexPath.row].threadForumID
        print("GO Thread > \(id_data)")
        let jump_destination = ["id": id_data, "forumID": f_data]
        print("Post <LandXForumJump>, object: \(jump_destination)")
        NotificationCenter.default.post(name: NSNotification.Name("LandXForumJump"), object: jump_destination)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return helperTableCell.cellCreateSwitch(text: "demo")
        tableViewSelf = tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TRFVCell
        
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        print("currentStatusNowPage \(currentStatusNowPage)")
        if (!currentStatusOnRefreshing ) {
            return nil
        }
        return vcLoadingFooter.view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
        //return vcLoadingHeader.view
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (currentStatusNowPage >= 3) {
            return 35.0
        }
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // TableView 动画
        /*
        let cell = cell
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 0.7, 1))
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        cell.layer.add(animation, forKey: "transform")
         */
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Scrool 处理
        scroolViewSelf = scrollView
        dealWithFooter()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scroolViewSelf = scrollView
        // 完全松开
    }
    
    func dealWithFooter() {
        if scroolViewSelf == nil || tableViewSelf == nil {
            print("<!> Nil scrool view, table view, skip deal with footer")
        }
        
        if tableViewSelf?.contentSize.height == 0 {
            return
        }
        
        if (currentStatusNowPage >= 3) {

            return
        }

        // 40: 偏移量用于稍微看到加载动画就触发网络请求与加载
        let footer_offset = tableViewSelf!.contentSize.height - tableViewSelf!.frame.size.height - 400
        
        if tableViewSelf!.contentOffset.y >= footer_offset {
            
            
            if (currentStatusOnRefreshing) {
                return
            }
            print(">> begin footer refreshing")
            //currentStatusOnRefreshing = true
            
            loadNetworkData()
            
            
            
        }
    }
    
}



class TRFVCell : UITableViewCell {
    

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
        
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            lbPO.backgroundColor = UIColor.tintColor
            lbSAGE.backgroundColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
        


        
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
富文本转换 > 迁移至 LCStruct 中完成
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
 
 /// 添加上拉刷新
 func setupRefreshUp() {
     

     //mainTableView.addSubview(mainRefresh)
     //mainRefresh.beginRefreshing()
     
     
     //mainTableView.scrollsToTop = true
     
     //mainRefresh.endRefreshing()
 }
*/
/*
 
 let network_get = DispatchQueue(label: "studio.tri.refresh.tableview")
 network_get.async {
     let API = LCAPI()
     if (self.config.viewerChannel == .forum) {
         self.currentStatusNowPage += 1
         let r_list = API.getForum(forumID: 4, forumPage: UInt(self.currentStatusNowPage))
         self.threadDisplayQueue.append(contentsOf: r_list)
         self.currentStatusOnRefreshing = false
         DispatchQueue.main.async {
             self.tableViewSelf?.reloadData()

         }
     }
 }
 
 */
