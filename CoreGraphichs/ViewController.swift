//
//  ViewController.swift
//  CoreGraphichs
//
//  Created by admin on 10/24/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var lbPlusView: UILabel!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var GraphView: GraphView!
    // custom
    @IBOutlet weak var averagerWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        lbPlusView.text = String(counterView.counter)
    }
    
    @IBAction func btPlusSum(_ sender: CoreGraphichs) {
        if sender.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
            // can phai cap nhat lai vong ngoai khi thay doi couter
        }
        lbPlusView.text = String(counterView.counter)
        // 
        if isGraphViewShowing {
          counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
        // hide graphView
        if isGraphViewShowing {
            // transitor tao ảnh chuyển động.
            UIView.transition(from: GraphView, to: counterView, duration: 1, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        } else {
            // show graphView
            UIView.transition(from: counterView, to: GraphView, duration: 1, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        isGraphViewShowing.toggle() // chuyển đỏi isGraph từ true sang false
    }
}

