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
    
    override func viewDidAppear(_ animated: Bool) {
        

    }
    
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
        if #available(iOS 15.0 ,macCatalyst 15.0, *) {
            block5.backgroundColor = UIColor.tintColor
        } else {
            
        }
        block6.backgroundColor = UIColor.systemFill
        block7.backgroundColor = UIColor.systemFill
        block8.backgroundColor = UIColor.systemFill
        block9.backgroundColor = UIColor.systemFill
        

        block1.layer.add(createCAAnimation(delay: 0), forKey: "addLayerAnimationMargin")
        block2.layer.add(createCAAnimation(delay: 0.07), forKey: "addLayerAnimationMargin")
        block3.layer.add(createCAAnimation(delay: 0.14), forKey: "addLayerAnimationMargin")
        block6.layer.add(createCAAnimation(delay: 0.21), forKey: "addLayerAnimationMargin")
        block9.layer.add(createCAAnimation(delay: 0.28), forKey: "addLayerAnimationMargin")
        block8.layer.add(createCAAnimation(delay: 0.35), forKey: "addLayerAnimationMargin")
        block7.layer.add(createCAAnimation(delay: 0.42), forKey: "addLayerAnimationMargin")
        block4.layer.add(createCAAnimation(delay: 0.49), forKey: "addLayerAnimationMargin")
        
        

        
    }
    
    func createCAAnimation(delay: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.repeatCount = .infinity
        animation.duration = 0.56
        animation.toValue = [ UIColor.tintColor.cgColor, UIColor.systemFill.cgColor]
        animation.fillMode = .both
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        return animation
    }


    

}

/*
Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
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

 */

/*

let view_animation = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0.0,options: [.autoreverse, .curveEaseIn, .repeat], animations: {
    

    
})

view_animation.startAnimation()
 */
