//
//  TRLoading.swift
//  LandX
//
//  Created by Ki MNO on 2024/1/7.
//

import UIKit

class TRLoading: UIViewController {
    
   
    @IBOutlet weak var block1: UILabel!
    @IBOutlet weak var block2: UILabel!
    @IBOutlet weak var block3: UILabel!
    @IBOutlet weak var block4: UILabel!
    @IBOutlet weak var block5: UILabel!
    @IBOutlet weak var block6: UILabel!
    @IBOutlet weak var block7: UILabel!
    @IBOutlet weak var block8: UILabel!
    @IBOutlet weak var block9: UILabel!

    
    var animationStack: [UILabel] = []
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animationStack.append(block1)
        animationStack.append(block2)
        animationStack.append(block3)
        animationStack.append(block6)
        animationStack.append(block9)
        animationStack.append(block8)
        animationStack.append(block7)
        animationStack.append(block4)
        
        block1.backgroundColor = UIColor.systemFill
        block2.backgroundColor = UIColor.systemFill
        block3.backgroundColor = UIColor.systemFill
        block4.backgroundColor = UIColor.systemFill
        block5.backgroundColor = UIColor.systemFill
        block6.backgroundColor = UIColor.systemFill
        block7.backgroundColor = UIColor.systemFill
        block8.backgroundColor = UIColor.systemFill
        block9.backgroundColor = UIColor.systemFill
        
        
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            // Animation
            if (self.currentIndex > 7) {
                self.currentIndex = 0
            }
            
            if (self.currentIndex == 0) {
                
                if #available(iOS 15.0 ,macCatalyst 15.0, *) {
                    self.animationStack[0].backgroundColor = UIColor.tintColor
                } else {
                    
                }
                self.animationStack[7].backgroundColor = UIColor.systemFill
                
            } else {
                if #available(iOS 15.0, macCatalyst 15.0, *) {
                    self.animationStack[self.currentIndex].backgroundColor = UIColor.tintColor
                } else {
                    
                }
                self.animationStack[self.currentIndex - 1].backgroundColor = UIColor.systemFill
            }
            
            self.currentIndex += 1
            
            
        }


        
        /*
        
        let view_animation = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0.0,options: [.autoreverse, .curveEaseIn, .repeat], animations: {
            

            
        })
        
        view_animation.startAnimation()
         */
        
    }


    

}
