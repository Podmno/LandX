//
//  VCPreferences.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/11.
//

import UIKit



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
    
    let tableCellCreator = TRTableCellCreator()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "用户管理"
        case 1:
            return "主界面偏好"
        case 2:
            return "显示设置"
        case 3:
            return "Plus 功能"
        case 4:
            return "关于 CrossLand"
        default:
            return "Null"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 1:
            return "决定主界面的展示形式。\n底部栏：在底部展示版面与页面切换器。\n侧边栏：在侧边展示版面列表。"
        default:
            return ""
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                return tableCellCreator.cellCreateStaticText(text: "X 岛账号登录")
            case 1:
                return tableCellCreator.cellCreateStaticText(text: "从 Cookie 登录")
            default:
                return tableCellCreator.cellCreateStaticText(text: "Null")
            }
        }
        if(indexPath.section == 1) {
            switch indexPath.row {
            case 0:
                return tableCellCreator.cellCreateCheckBox(text: "底部栏", checked: true)
            case 1:
                return tableCellCreator.cellCreateCheckBox(text: "侧边栏", checked: false)
            default:
                return tableCellCreator.cellCreateStaticText(text: "Null")
            }
        }
        if(indexPath.section == 2) {
            switch indexPath.row {
            case 0:
                return tableCellCreator.cellCreateSwitch(text: "显示图片", status: true)
            case 1:
                return tableCellCreator.cellCreateSwitch(text: "默认原图", status: false)
            default:
                return tableCellCreator.cellCreateStaticText(text: "Null")
            }
        }
        return tableCellCreator.cellCreateStaticText(text: "Null")
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

/*
 
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
 
 */
