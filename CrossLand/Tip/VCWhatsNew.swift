//
//  VCWhatsNew.swift
//  LandX
//
//  Created by Ki MNO on 2023/12/20.
//

import UIKit


let flagAlwaysDisplayWhatsNew = true

class VCWhatsNew: UIViewController {

    let manager = UserDefaults.standard
   
    let sbMainLand = UIStoryboard(name: "MainLand", bundle: Bundle.main)
    
    var vcMain: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vcMain = sbMainLand.instantiateInitialViewController()
    }
   
    
    @available(*, deprecated, message: "Do not use display function.")
    func display(parent: UIViewController) {
        if !getDisplayStatus() {
            parent.present(self, animated: true)
            return
        }
        if flagAlwaysDisplayWhatsNew {
            parent.present(self, animated: true)
        }
        
    }
    
    func getDisplayStatus() -> Bool {
        return manager.bool(forKey: "landX.firstLaunchScreen.viewed")
    }
    
    
    @IBAction func btnOKClicked(_ sender: Any) {
        
        manager.setValue(true, forKey: "landX.firstLaunchScreen.viewed")
        
        
        vcMain?.modalPresentationStyle = .fullScreen
        vcMain?.modalTransitionStyle = .flipHorizontal
        self.present(vcMain!, animated: true)
        //self.dismiss(animated: true)
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
