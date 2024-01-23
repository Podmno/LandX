//
//  TRForumViewerTable.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/12.
//

import UIKit

/// 核心 FormView Tabe View
class TRFVTable : UIViewController {
    
    @IBOutlet weak var tableViewCell: TRFVCell!
    
    @IBOutlet weak var mainTableView: UITableView!
    let mainTable = TRVCFVTableMain()
    
    var loadingAnimationView: TRLoading? = nil

    var threadListData: [LSThread] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = mainTable
        mainTableView.dataSource = mainTable
        mainTableView.backgroundView = nil
        mainTableView.backgroundView = UIView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initForumDataLoad()

    }
    

    public func setupConfig(config: TRFVConfig) {
        mainTable.resetTableView(config: config)
    }
    
    public func loadData() {
        self.mainTable.loadNetworkData()
    }

    
    func setupTableForum() {
        print("< remove")
        
        //mainTable.threadDisplayQueue.append(contentsOf: threadListData)

        
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
        
    }
    


}


class TRVCFVTableMain : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    let vcLoadingFooter = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
    let vcLoadingHeader = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
    
    var viewHeader: UIView? = nil
    
    var tableViewSelf: UITableView? = nil
    
    var scroolViewSelf: UIScrollView? = nil
    
    /// 用于 Thread View：当前的 Po 主名字
    var threadViewCurrentPoCookie: String = ""
    
    /// 配置：0：展示 Forum / 1：展示 Timeline / 2：展示 Thread
    public var config = TRFVConfig()
    
    /// 是否允许页面刷新（用于防止重复刷新）
    var currentStatusOnRefreshing = true
    
    /// 当前最下方加载的页面标记
    var currentStatusNowPage: UInt = 0
    
    /// 用于标记是不是到头了
    var currentStatusIsLastPage: Bool = false
    
    // TableViewCell Stack
    var tableViewCell : [UITableViewCell] = []
    
    /// 上次记录的刷新 Index
    var recordLastRefreshIndex = 0
    
    /// 根据 ID 记录已经被添加过的内容，添加过就不再展示第二次了
    var recordDisplayedID: [UInt] = []

    //let threadXIBStoryboard = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
    public var threadDisplayQueue: [LSThread] = []

    override init() {
        super.init()

        
    }
    
    func loadNetworkData() {
        
        self.currentStatusOnRefreshing = true
        self.currentStatusNowPage += 1
        print(self.config)
        let queue = DispatchQueue.init(label: "landX.networkRequest.mainData")
        
        queue.async {
            
            let API = LCAPI()
            
            if (self.config.viewerChannel == .forum) {
                let r_list = API.getForum(forumID: self.config.defaultValueID, forumPage: self.currentStatusNowPage)
                
                // Append Forum Data
                
                for f_data in r_list {
                    if(!self.recordDisplayedID.contains(f_data.threadID)) {
                        self.recordDisplayedID.append(f_data.threadID)
                        self.threadDisplayQueue.append(f_data)
                    }
                }
            }
            
            if (self.config.viewerChannel == .timeline) {
                
                let r_list = API.getTimeline(timelineID: self.config.defaultValueID, timelinePage: self.currentStatusNowPage)
                
                for f_data in r_list {
                    if(!self.recordDisplayedID.contains(f_data.threadID)) {
                        self.recordDisplayedID.append(f_data.threadID)
                        self.threadDisplayQueue.append(f_data)
                    }
                }
                
            }
            
            if (self.config.viewerChannel == .thread) {
                
                // 分页处理
                let t_list = API.getThread(threadID: self.config.defaultValueID, threadPage: self.currentStatusNowPage)
                
                if (self.currentStatusNowPage == 1) {
                    print("Setup Current Thread User Hash: \(t_list.threadUserHash)")
                    self.threadViewCurrentPoCookie = t_list.threadUserHash
                    self.threadDisplayQueue.append(t_list)
                }
                
                print("Thread Replies Count: \(t_list.threadReplies.count)")
                print("Thraed Reply 0 Thread ID : \(t_list.threadReplies[0].threadID)")
                if (t_list.threadReplies.count == 1 && t_list.threadReplies[0].threadID == 9999999) {
                    self.currentStatusIsLastPage = true
                    print("Is last page, skip update.")
                }
                
                for th in t_list.threadReplies {
                    if (!self.recordDisplayedID.contains(th.threadID)) {
                        self.recordDisplayedID.append(th.threadID)
                        self.threadDisplayQueue.append(th)
                    }
                }
                //self.threadDisplayQueue.append(contentsOf: t_list.threadReplies)
            }
            
            
            DispatchQueue.main.async {
                self.tableViewSelf?.reloadData()
                
                self.recordLastRefreshIndex = self.threadDisplayQueue.count
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemBackground
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select indexPath \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (config.viewerType == .detailView) {
            return
        }
        
        let id_data = threadDisplayQueue[indexPath.row].threadID
        let f_data = threadDisplayQueue[indexPath.row].threadForumID
        print("GO Thread > \(id_data)")
        let jump_destination = ["id": id_data, "forumID": f_data]
        print("Post <LandXForumJump>, object: \(jump_destination)")
        NotificationCenter.default.post(name: NSNotification.Name("LandXForumJump"), object: jump_destination)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        tableViewSelf = tableView

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TRFVCell
        
        cell.setupThread(thread: threadDisplayQueue[indexPath.row])
        cell.poUserHash = self.threadViewCurrentPoCookie
        cell.updateCell()
        
        
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
        //print("currentStatusNowPage \(currentStatusNowPage)")
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
        if (currentStatusNowPage >= config.maximumPageDisplay) {
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
        
        if (currentStatusNowPage >= config.maximumPageDisplay) {

            return
        }
        
        if (threadDisplayQueue.count == 0) {
            return
        }

        // 40: 偏移量用于稍微看到加载动画就触发网络请求与加载
        let footer_offset = tableViewSelf!.contentSize.height - tableViewSelf!.frame.size.height - 300
        
        if tableViewSelf!.contentOffset.y >= footer_offset {
            
            
            if (currentStatusOnRefreshing) {
                return
            }
            
            if (currentStatusIsLastPage == true) {
                return
            }
            print(">> begin footer refreshing")
            //currentStatusOnRefreshing = true
            
            loadNetworkData()
            
        }
    }
    
    public func resetTableView(config: TRFVConfig) {
        
        print("Reset All TableView Content.")
        self.config = config
        self.threadDisplayQueue.removeAll(keepingCapacity: true)
        self.tableViewSelf?.reloadData()
        self.tableViewSelf?.layoutIfNeeded()
        self.currentStatusNowPage = 0
        self.currentStatusOnRefreshing = false
        self.recordLastRefreshIndex = 0
        self.currentStatusIsLastPage = false
        self.recordDisplayedID.removeAll()
        self.loadNetworkData()
    }
}



class TRFVCell : UITableViewCell {
    
    var poUserHash: String = ""
    
    var finishUpdated: Bool = false
    
    var thread: LSThread = LSThread()
    
    let API = LCAPI()
    
    override func awakeFromNib() {
        //updateCell()
    }
    
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
    
    let loading_animation_view = TRLoading(nibName: "TRLoading", bundle: Bundle.main)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
        }
    }
    
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
    func imageViewVisable(visibility: Bool) {
        if (visibility == true) {
            self.csImgViewWidth.constant = 150.0
            self.csImgViewHeight.constant = 150.0
            self.updateConstraints()
        } else {
            self.csImgViewWidth.constant = 0.0
            self.csImgViewHeight.constant = 0.0
            self.updateConstraints()
        }
        
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
    }
    
    func showPoInfo() {

    }
    
    /// 用 Thread 信息更新 Cell
    func updateCell() {
        
        
        lbPO.backgroundColor = UIColor.tintColor
        lbSAGE.backgroundColor = UIColor.tintColor

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
        

        
        if (thread.threadUserHash == poUserHash) {
            lbUser.textColor = .tintColor
            lbPO.isHidden = false
        } else {
            lbUser.textColor = UIColor.label
            lbPO.isHidden = true
        }
        
        
        // 目前暂时禁用部分功能
        if (!thread.threadImg.isEmpty) {
            imageViewVisable(visibility: true)
            loading_animation_view.view.frame = imgView.bounds
            imgView.addSubview(loading_animation_view.view)
            loading_animation_view.view.isHidden = false
            loading_animation_view.awakeFromNib()
            
            let cdn_url = LCStorage.shared.getCDNImageURL()
            let image_url = cdn_url + "thumb/" + thread.threadImg + thread.threadExt
            print("Load URL Target : \(image_url)")
            
            API.pictureThumbDownload(targetURL: image_url) {image in
                DispatchQueue.main.async {
                    print(">>> setup UIImage")
                    let data = image.pngData()
                    let ui_image = UIImage(data: data!, scale: UIScreen.main.scale)
                    debugPrint(ui_image)
                    self.loading_animation_view.view.isHidden = true
                    self.imgView.image = ui_image
                }
            }
            
        } else {
            imageViewVisable(visibility: false)
            loading_animation_view.view.isHidden = true
        }
        
        
        
        hideReplyLabel()
        hideBtnGoThread()
        
        finishUpdated = true
    }
    
    func cellSpecial() {
        print("\(self.thread.threadUserHash) --- \(poUserHash)")
        if (self.thread.threadUserHash == poUserHash) {
            lbUser.textColor = .tintColor
            lbPO.isHidden = false
        }
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
