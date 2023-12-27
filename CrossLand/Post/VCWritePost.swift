//
//  VCWritePost.swift
//  LandX
//
//  Created by Ki MNO on 2023/9/8.
//

import UIKit

class VCWritePost: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var btnEmoticon: UIBarButtonItem!
    let vcEmoticonInput = VCEmoticonInput(nibName: "VCEmoticonInput", bundle: Bundle.main)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnClickedPost(_ sender: Any) {
        
    }
    
    
    @IBAction func btnClickedEmoticon(_ sender: Any) {
        
        vcEmoticonInput.modalPresentationStyle = .popover
        vcEmoticonInput.popoverPresentationController?.sourceView = self.toolBar
        vcEmoticonInput.popoverPresentationController?.sourceRect = self.toolBar.bounds
        //vcEmoticonInput.popoverPresentationController?.sourceView = self.btnWritePost
        //vcEmoticonInput.popoverPresentationController?.sourceRect = self.btnWritePost.bounds
        vcEmoticonInput.popoverPresentationController?.delegate = self
        vcEmoticonInput.view.backgroundColor = UIColor.clear
        self.present(vcEmoticonInput, animated: true)
        
        
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func btnClickedCancel(_ sender: Any) {
        self.dismiss(animated: true)
        //self.view.removeFromSuperview()
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
