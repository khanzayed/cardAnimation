//
//  ViewController.swift
//  tinder
//
//  Created by Faraz Habib on 26/09/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var acceptImageView: UIImageView!
    
    var divisor : CGFloat!
    var top : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        divisor = (view.frame.width / 2) / 0.61
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset() {
        UIView.animate(withDuration: 0.4, animations: {
            self.card.center = self.view.center
            self.acceptImageView.alpha = 0
            self.card.alpha = 1
            self.card.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }) { (true) in
            self.acceptImageView.image = nil
        }
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func thumbMoved(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: self.view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        let scale = min(100/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if xFromCenter > 0 { // Right
            acceptImageView.image = UIImage(named: "accept")
        } else {
            acceptImageView.image = UIImage(named: "accept")
        }
        
        acceptImageView.alpha = abs(xFromCenter) / view.center.x
        
        switch sender.state {
        case .ended:
            if card.center.x < 100 {
                UIView.animate(withDuration: 0.4, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 150)
                    card.alpha = 0
                }) { (true) in
                    self.acceptImageView.image = nil
                }
            } else if card.center.x > view.frame.width - 100 {
                UIView.animate(withDuration: 0.4, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 150)
                    card.alpha = 0
                }) { (true) in
                    self.acceptImageView.image = nil
                }
            } else {
                reset()
            }
        default:
            break
        }
        
    }
    
}

