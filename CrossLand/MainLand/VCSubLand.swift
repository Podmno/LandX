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
    
    // MARK: Var
    
    var stateCurrentThreadID: UInt = 0
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lbTopTitle.text = "No.\(stateCurrentThreadID)"
    }

    // MARK: - Public Functions
    
    public func setSubLandThreadID(tid: UInt) {
        self.stateCurrentThreadID = tid
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
