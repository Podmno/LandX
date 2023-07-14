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
    func cellCreateSwitch(text: String) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessoryView = UISwitch()
        var content = cell.defaultContentConfiguration()
        
        content.text = text
        
        cell.contentConfiguration = content
        return cell
        
    }
    

    
    
    
}
