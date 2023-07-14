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
        mainTable.loadData()
        mainTableView.delegate = mainTable
        mainTableView.dataSource = mainTable
        mainTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }

    
}


class TRVCForumViewerTableMain : NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    var threadStack : [TRForumViewerThread] = []
    let threadXIBStoryboard = UIStoryboard(name: "TRForumViewer", bundle: Bundle.main)
    
    func loadData() {
        for _ in 0...5 {
            let vcThread = threadXIBStoryboard.instantiateViewController(withIdentifier: "TRForumThread") as! TRForumViewerThread
            
            threadStack.append(vcThread)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return helperTableCell.cellCreateSwitch(text: "demo")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            //threadStack[indexPath.row].view.frame = CGRectMake(0, 0, tableView.frame.width, 300.0)
            cell!.contentView.addSubview(threadStack[indexPath.row].view)
            cell?.sizeToFit()
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    


    
}
