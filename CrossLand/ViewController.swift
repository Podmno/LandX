//
//  ViewController.swift
//  LandX
//
//  Created by Ki MNO on 2023/7/8.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    

    let sbMainLand = UIStoryboard(name: "MainLand", bundle: Bundle.main)
    
    @IBOutlet weak var progressLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var lbLoading: UILabel!
    
    var vcMain: UIViewController? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        vcMain = sbMainLand.instantiateInitialViewController()
        
        //checkNetworkConnection()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //showBetaProgramViewController()
        
        //vcPreferences = sbPreferences.instantiateInitialViewController()
        //self.navigationController?.pushViewController(vcPreferences!, animated: true)


        vcMain?.modalPresentationStyle = .fullScreen
        self.present(vcMain!, animated: true)
        
        
        //self.navigationController?.pushViewController(vcMain!, animated: true)
    }
    
    
    func checkNetworkConnection() {
        progressLoading.startAnimating()
        self.progressLoading.isHidden = false
        let que = DispatchQueue(label: "studio.tri.LandX.networkCheck")
        que.async {
            let re = LCRequest()
            let test_cdn_url = re.getCDNPath()
            if(test_cdn_url.contains("LCRequest.Error.Alamofire")) {
                DispatchQueue.main.async {
                    self.uiDisplayNetworkError(supportMessage: test_cdn_url)
                }
            } else {
                print("> Remote CDN Url : \(test_cdn_url)")
            }
        }
    }
    

    
    func uiDisplayNetworkError(supportMessage: String) {
        
        self.progressLoading.stopAnimating()
        self.progressLoading.isHidden = true
        
        self.lbLoading.alpha = 0.0


        UIView.animate(withDuration: 0.7) {
            self.lbLoading.alpha = 1.0
        }
        
        self.lbLoading.text = "网络连接失败，请检查互联网连接后再试。\n\nSupport Message: \n\(supportMessage)"

        
    }
    
    
    @IBAction func btnClickedRetry(_ sender: Any) {
        print("Network Checker - User Retry")
        
        checkNetworkConnection()
    }
    

}

// 侧滑返回设定
// 设定根视图需要为 NavigationViewController 此处在根视图禁用侧滑返回否则会出现奇怪的问题
/*
if(self == navigationController?.viewControllers[0]) {
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    
} else {
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
}

self.navigationController?.interactivePopGestureRecognizer?.delegate = self

*/

/*
    @IBAction func btnClickedPreferences(_ sender: Any) {
        

        //vcPreferences = sbPreferences.instantiateInitialViewController()
        //self.present(vcPreferences!, animated: true)
        //self.navigationController?.pushViewController(vcPreferences!, animated: true)
    }
    
    
    @IBAction func btnClickedForumTableDebug(_ sender: Any) {
        
        //let s = UIStoryboard(name: "Debug", bundle: Bundle.main)
        //vcDebugTableView = s.instantiateInitialViewController()
        //self.navigationController?.pushViewController(vcDebugTableView!, animated: true)
    }
 
 
 func showBetaProgramViewController() {
     if(!displayBetaProgramHint) {
         return
     }
     
     print("> show beta program view controller")
     
     vcBetaProgramViewController = sbPreView.instantiateInitialViewController()
     

     //self.navigationController?.pushViewController(vcBe, animated: )
     self.present(vcBetaProgramViewController!, animated: true)
     displayBetaProgramHint = false
 }
 
 */
