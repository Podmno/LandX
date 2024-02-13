//
//  VCLandLogin.swift
//  LandX
//
//  Created by Ki MNO on 2023/12/20.
//

import UIKit

class VCLandLogin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }

        let keyboardHeight = keyboardFrame.size.height
        let offset: CGFloat = 20 // 输入框或视图距离键盘的偏移量
        
        // 计算输入框或视图需要上移的距离
        let moveHeight = keyboardHeight + offset
        
        // 将输入框或视图向上移动
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: -moveHeight, width: self.view.bounds.width, height: self.view.bounds.height)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // 将输入框或视图恢复原来的位置
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }
    }



    @IBAction func btnClickedBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
