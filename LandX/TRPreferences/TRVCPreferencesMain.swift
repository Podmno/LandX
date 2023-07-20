//
//  VCPreferences.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/11.
//

import UIKit

enum TRPreferencesType {
    case staticText
    case switchButton
    case pageHeader
    case pageFooter
    
}

class TRPreferencesStruct : NSObject {
    
    public var title: NSString = ""
    public var type: TRPreferencesType = .staticText
    public var subTitle: NSString = ""
    
    public override init() {
        super.init()
    }
    
}

class TRPreferencesSection : NSObject {
    
    public var title: NSString = ""
    public var content: NSMutableArray = []
    
    public override init() {
        super.init()
    }
    
}

class TRPreferencesConfig : NSObject {
    
    public var config: NSMutableArray = NSMutableArray()
    
    public override init() {
        super.init()
    }
    
    public func getSectionCount(prefSection: TRPreferencesSection) -> Int {
        
        var totalCount = 0
        
        for pr in prefSection.content {
            let s = pr as! TRPreferencesStruct
            if(s.type == .pageHeader) {
                totalCount += 1
            }
        }
        
        return totalCount
        
    }
    
    
    
    
}

class TRVCPreferencesMain : UIViewController {
    
    @IBOutlet weak var tvMainContent: UITableView!
    
    
    let tableViewMainContentProvider = VCPreferencesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMainContent.delegate = tableViewMainContentProvider
        tvMainContent.dataSource = tableViewMainContentProvider
        
        // 为 iOS 15 样式的列表视图打补丁
        // 如果按默认的高度会显示不全
        //tvMainContent.sectionHeaderHeight = 28.0
        //tvMainContent.estimatedSectionFooterHeight = 28.0
        //tvMainContent.sectionFooterHeight = 30.0
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tvMainContent.reloadData()
    }
    
    
    
    @IBAction func btnClickedComplete(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


class VCPreferencesTableView : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    let helperTableCell = TRTableCellCreator()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return helperTableCell.cellCreateCheckBox(text: "demo", checked: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CrossLand 设定"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "无法在 TestFlight 区间内修改这些内容。\n无法在 TestFlight 区间内修改这些内容。"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
}
