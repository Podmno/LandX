//
//  TRTableCellCreator.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/11.
//

import UIKit

/// 生成基本款式的 Table View Cell 样式
class TRTableCellCreator {
    
    
    /// 静态文字
    func cellCreateStaticText(text: String) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        
        content.text = text
        
        cell.contentConfiguration = content
        return cell
    }
    
    /// 带有按钮的 Cell
    func cellCreateSwitch(text: String, status: Bool) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let switcher = UISwitch()
        if(status) {
            switcher.setOn(true, animated: false)
        } else {
            switcher.setOn(false, animated: false)
        }
        
        cell.accessoryView = switcher
        
        
        var content = cell.defaultContentConfiguration()
        
        content.text = text
        
        cell.contentConfiguration = content
        return cell
        
    }
    
    /// 带有右侧说明的 Cell
    func cellCreateSelection(text: String, selection: String) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessibilityLabel = selection
        var content = cell.defaultContentConfiguration()
        content.text = text
        
        cell.contentConfiguration = content
        return cell
        
    }
    
    
    /// 带有 CheckBox 的 Cell
    func cellCreateCheckBox(text: String, checked: Bool) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if(checked == true) {
            cell.accessoryType = .checkmark
        }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = text
        
        cell.contentConfiguration = content
        return cell
        
    }
    
    
    
}
