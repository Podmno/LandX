//
//  TRForumViewerThread.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/12.
//

import UIKit
import CoreGraphics

class TRForumViewerThread : UIViewController {
    
    
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbPo: UILabel!
    @IBOutlet weak var lbSAGE: UILabel!
    @IBOutlet weak var lbDate: UILabel!

    
    @IBOutlet weak var lbMain: UILabel!
    
    @IBOutlet weak var lbNo: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tvMain.textContainerInset = UIEdgeInsets.zero
        //tvMain.textContainer.lineFragmentPadding = 0
        
    }
    
    override func viewDidLayoutSubviews() {
        lbMain.sizeToFit()
        lbMain.numberOfLines = 0
    }

    
    public func generateDemoContent() {
        

        
        
    }
    
}
