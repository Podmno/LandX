//
//  VCCookieManage.swift
//  LandX
//
//  Created by Ki MNO on 2023/9/8.
//

import UIKit

class VCCookieManage: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    let manageTableViewDelegate = VCCookieManageTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainTableView.dataSource = manageTableViewDelegate
        mainTableView.delegate = manageTableViewDelegate
    }

    @IBAction func btnClickedFinish(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class VCCookieManageTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    func createTextButton(text: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .none

        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = text
            cell.contentConfiguration = content
            
        } else {
            cell.textLabel?.text = text
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1) {
            return 2
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 1) {
            
            if(indexPath.row == 0) {
                return createTextButton(text: "拍摄二维码导入饼干")
            } else {
                return createTextButton(text: "从相册选择二维码导入饼干")
            }
            
        } else {
            
            return createTextButton(text: "添加新的饼干")
        }
        
    }
    
    
}
