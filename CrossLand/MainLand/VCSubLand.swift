//
//  VCSubLand.swift
//  LandX
//
//  Created by Ki MNO on 2024/1/20.
//

import UIKit

class VCSubLand: UIViewController {
    
    // MARK: IB Elements
    
    @IBOutlet weak var lbTopTitle: UILabel!
    @IBOutlet weak var mainViewContainer: UIView!
    @IBOutlet weak var btnBack: UIButton!
    // MARK: Var
    
    var stateCurrentThreadID: UInt = 0
    var stateLastForumName: String = " 返回"
    
    
    // MARK: View Controller
    
    var vcForumTable: TRFVTable? = nil
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lbTopTitle.text = "No.\(stateCurrentThreadID)"
        self.btnBack.setTitle(" "+stateLastForumName, for: .normal)
        
        // Init TRFV
        let storyboard_forum_table = UIStoryboard(name: "TRFV", bundle: Bundle.main)
        self.vcForumTable = storyboard_forum_table.instantiateViewController(withIdentifier: "TRForumTable") as? TRFVTable

        var thread_config = TRFVConfig()
        thread_config.viewerChannel = .thread
        thread_config.defaultValuePage = 0
        thread_config.defaultValueID = stateCurrentThreadID
        thread_config.viewerType = .detailView
        vcForumTable?.setupConfig(config: thread_config)
        //vcForumTable?.loadData()
        //vcForumTable?.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Set TRFV Bounds
        vcForumTable!.view.frame = mainViewContainer.bounds
        mainViewContainer.addSubview(vcForumTable!.view)
        vcForumTable?.didMove(toParent: self)
        
        
    }

    // MARK: - Public Functions
    
    public func setSubLandThreadID(tid: UInt) {
        self.stateCurrentThreadID = tid
    }

    public func setSubLandForumName(fName: String) {
        self.stateLastForumName = fName
    }

    // MARK: - IBOutlet And IBAction
    
    

    @IBAction func btnClickedBack(_ sender: Any) {
        if(self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}
