//
//  VCPreferences.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/11.
//

import UIKit

//
//
//  
//

let prefConfirguation: Any = [
    
    TRPrefSection(sectionTitle: "饼干管理",sectionDescription: "", sectionContent: [
        TRPrefCell(title: "我的饼干管理", type: .button, keyPath: "landXpref.button.CookieManage")
    ]),
    TRPrefSection(sectionTitle: "用户登录",sectionDescription: "", sectionContent: [
        TRPrefCell(title: "X 岛用户登录", type: .button, keyPath: "landXpref.button.UserLogin")
    ]),

    TRPrefSection(sectionTitle: "图片加载偏好",sectionDescription: "", sectionContent: [
        TRPrefCell(title: "蜂窝网络下自动加载图片", type: .switchButton, keyPath: "landXpref.switchbutton.autoPicLoad"),
        TRPrefCell(title: "始终显示原图", type: .switchButton, keyPath: "landXpref")
    ]),
    TRPrefSection(sectionTitle: "缓存管理",sectionDescription: "清理缓存数据包括：临时保存的图片与帖子信息、缓存的版面信息与列表。", sectionContent: [
        TRPrefCell(title: "清理软件缓存", type: .button, keyPath: "landXpref.button.CacheClear")
    ]),
    TRPrefSection(sectionTitle: "关于软件",sectionDescription: "版本 1.0", sectionContent: [
        TRPrefCell(title: "开源代码使用 & STAFF CREDITS", type: .button, keyPath: "landXpref.button.STAFF")
    ]),


]

//
//
//
//

/// Table View Cell 的样式描述
enum TRPrefCellType {
    case button
    case checkboxGroup
    case switchButton
    // case custom
}

/// Table View Cell
struct TRPrefCell {
    
    var title: String = ""
    var subTitle: String = ""
    
    
    var type: TRPrefCellType = .button
    
    var keyPath: String = ""
    
}
 
struct TRPrefSection {
    
    var sectionTitle: String = ""
    var sectionDescription: String = ""
    
    
    var sectionContent: Array<TRPrefCell> = []
    
}



/// 生成基本款式的 Table View Cell 样式
class TRPrefTableCellCreator {
    
    
    
    
    /// 静态文字 包含次要文字
    func cellCreateStaticText(text: String, subText: String) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = text
            content.secondaryText = subText
            cell.contentConfiguration = content
            
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = text + "\n" + subText
            
        }
        
        
        return cell
    }
    
    /// 带有按钮的 Cell
    func cellCreateSwitch(text: String, subText: String, status: Bool) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let switcher = UISwitch()
        if(status) {
            switcher.setOn(true, animated: false)
        } else {
            switcher.setOn(false, animated: false)
        }
        
        cell.accessoryView = switcher
        
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = text
            content.secondaryText = subText
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = text + "\n" + subText
        }
        
        
        return cell
        
    }
    
    /// 带有右侧说明的 Cell
    func cellCreateSelection(text: String,subText: String, selection: String) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessibilityLabel = selection
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = text
            content.secondaryText = subText
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = text + "\n" + subText
        }

        return cell
        
    }
    
    
    /// 带有 CheckBox 的 Cell
    func cellCreateCheckBox(text: String, subText: String ,checked: Bool) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if(checked == true) {
            cell.accessoryType = .checkmark
        }
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = text
            content.secondaryText = subText
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = text + "\n" + subText
        }
        

        return cell
        
    }

}


class TRVCPreference : UIViewController {
    
    @IBOutlet weak var tvMainContent: UITableView!
    
    let tableViewMainContentProvider = VCPreferenceTableView()
    
    
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
        
        
        let action_CookieManage = {
            
            // FIXME: [WindowHosting] UIScene property of UINSSceneViewController was accessed before it was set.
            // 2023-09-09 17:33:16.862880+0800 CrossLand[1609:52725] Scene destruction request failed with error: (null)
            
            //let cookie_manager = VCCookieManage(nibName: "VCCookieManage", bundle: Bundle.main)
            //self.present(cookie_manager, animated: true)
            let err = TRProblemReporter()
            err.showErrorMessage(parentController: self)
            
        }
        
        self.tableViewMainContentProvider.setActionForKeyPath(keyPath: "landXpref.button.CookieManage", action: action_CookieManage)
        
        
    }
    
    
    @IBAction func btnClickedComplete(_ sender: Any) {
        if(self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
        
        
    }
}


class VCPreferenceTableView : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    let tableCellCreator = TRPrefTableCellCreator()
    var actionDictionary: Dictionary<String, () -> ()> = [:]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (prefConfirguation as! Array<Any>).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let config_array = prefConfirguation as! Array<TRPrefSection>
        return config_array[section].sectionTitle
        
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let config_array = prefConfirguation as! Array<TRPrefSection>
        return config_array[section].sectionDescription
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let config_array = prefConfirguation as! Array<TRPrefSection>
        let config_cell = config_array[section]
        return config_cell.sectionContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let config_array = prefConfirguation as! Array<TRPrefSection>
        let config_cell = config_array[indexPath.section]
        
        let config_cellContent = config_cell.sectionContent[indexPath.row]
        
        switch config_cellContent.type {
        case .button:
            return tableCellCreator.cellCreateStaticText(text: config_cellContent.title, subText: config_cellContent.subTitle)
        case .checkboxGroup:
            return tableCellCreator.cellCreateCheckBox(text: config_cellContent.title,subText: config_cellContent.subTitle, checked: true)
        case .switchButton:
            return tableCellCreator.cellCreateSwitch(text: config_cellContent.title,subText: config_cellContent.subTitle, status: false)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        // 处理点击
        
        let config_array = prefConfirguation as! Array<TRPrefSection>
        let config_cell = config_array[indexPath.section]
        
        let config_cellContent = config_cell.sectionContent[indexPath.row]
        

        
        switch config_cellContent.type {
        case .button:
            if(actionDictionary[config_cellContent.keyPath] != nil) {
                let ac = actionDictionary[config_cellContent.keyPath]!
                ac()
            }
            break
        case .checkboxGroup:
            // 更新 CheckMark 状态
            let cell = tableView.cellForRow(at: indexPath)
            
            if(cell?.accessoryType == .checkmark) {
                cell?.accessoryType = .none
            } else {
                cell?.accessoryType = .checkmark
            }
            
            break
        case .switchButton:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 由 KeyPath 指定按钮的动作
    public func setActionForKeyPath(keyPath: String, action: @escaping () -> ()) {
        
        actionDictionary[keyPath] = action
        
    }

    
}


public class TRPreference : NSObject {
    
    
    
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
 
 
 TRPrefSection(sectionTitle: "首页样式",sectionDescription: "", sectionContent: [
     TRPrefCell(title: "底栏", subTitle: "在主界面的底部显示版面与页面切换器",type: .checkboxGroup, keyPath: "landXpref.checkbox.buttonBar"),
     TRPrefCell(title: "侧边栏", subTitle: "在主页面侧滑以切换版面",type: .checkboxGroup, keyPath: "landXpref.checkbox.sideBar"),
     
 ]),
 
 */
