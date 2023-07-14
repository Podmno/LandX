//
//  ViewController.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/8.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let sbPreView = UIStoryboard(name: "PreView", bundle: Bundle.main)
    let sbPreferences = UIStoryboard(name: "TRPreferences", bundle: Bundle.main)
    
    
    var vcBetaProgramViewController: UIViewController? = nil
    var vcPreferences: UIViewController? = nil
    var vcDebugTableView: UIViewController? = nil
    
    
    var displayBetaProgramHint = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 侧滑返回设定
        // 设定根视图需要为 NavigationViewController 此处在根视图禁用侧滑返回否则会出现奇怪的问题
        if(self == navigationController?.viewControllers[0]) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showBetaProgramViewController()
    }
    
    func showBetaProgramViewController() {
        if(!displayBetaProgramHint) {
            return
        }
        
        print("show beta program view controller")
        
        vcBetaProgramViewController = sbPreView.instantiateInitialViewController()
        

        //self.navigationController?.pushViewController(vcBe, animated: )
        self.present(vcBetaProgramViewController!, animated: true)
        displayBetaProgramHint = false
    }
    

    @IBAction func btnClickedPreferences(_ sender: Any) {
        

        vcPreferences = sbPreferences.instantiateInitialViewController()
        //self.present(vcPreferences!, animated: true)
        self.navigationController?.pushViewController(vcPreferences!, animated: true)
    }
    
    
    @IBAction func btnClickedForumTableDebug(_ sender: Any) {
        
        let s = UIStoryboard(name: "Debug", bundle: Bundle.main)
        vcDebugTableView = s.instantiateInitialViewController()
        self.navigationController?.pushViewController(vcDebugTableView!, animated: true)
    }
    
}

