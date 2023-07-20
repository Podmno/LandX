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
        mainTableView.reloadData()
    }

    
}


class TRVCForumViewerTableMain : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    var threadStack : [TRForumViewerThread] = []
    //let threadXIBStoryboard = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return helperTableCell.cellCreateSwitch(text: "demo")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        //cell?.contentView.addSubview(threadStack[indexPath.row].view)

        
        
        
        return cell!
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
