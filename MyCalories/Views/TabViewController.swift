//
//  TabViewController.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 21..
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightGestureRecognizer.numberOfTouchesRequired = 1
        rightGestureRecognizer.direction = .right
        self.view.addGestureRecognizer(rightGestureRecognizer)
        
        let leftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftGestureRecognizer.numberOfTouchesRequired = 1
        leftGestureRecognizer.direction = .left
        self.view.addGestureRecognizer(leftGestureRecognizer)
        
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
            case .left:
                if selectedIndex < 3 {
                    self.selectedIndex = self.selectedIndex + 1
            }
            case .right:
                if selectedIndex > 0 {
                    self.selectedIndex = self.selectedIndex - 1
            }
            default: break
        }
    }
}
