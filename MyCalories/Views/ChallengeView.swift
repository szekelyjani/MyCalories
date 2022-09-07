//
//  ChallangeView.swift
//  MyCalories
//
//  Created by Szekely Janos on 2022. 08. 20..
//

import UIKit

class ChallengeView: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var numberOfPushUpsLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    private var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let rectangle = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        rectangle.layer.cornerRadius = 100
        rectangle.backgroundColor = .red
        rectangle.center = view.center
        view.addSubview(rectangle)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        rectangle.addGestureRecognizer(gestureRecognizer)
        
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        counter += 1
        numberOfPushUpsLabel.text = "\(counter)"
    }
    
    @IBAction func resetButtonTouchUpInside(_ sender: Any) {
        counter = 0
        numberOfPushUpsLabel.text = "Tap the circle with your nose"
    }
    
}
