//
//  FVCellA.swift
//  LandX
//
//  Created by Ki MNO on 2024/1/22.
//

import UIKit

class FVCellA: UITableViewCell {
    
    var thread = LSThread()
    @IBOutlet weak var lbMain: UILabel!
    
    @IBOutlet weak var lbUser: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var lbNo: UILabel!
    @IBOutlet weak var btnPo: UIButton!
    
    @IBOutlet weak var btnSAGE: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbMain.text = thread.threadContent
        lbUser.text = thread.threadUserHash
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    public func setupThread(thread: LSThread) {
        self.thread = thread
    }
}
