//
//  ViewController.swift
//  Week4Lab
//
//  Created by Danny Glover on 4/19/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenDown: CGPoint?
    var trayOriginalCenter: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var existingFaceOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayCenterWhenOpen = CGPoint(x: view.frame.size.width / 2, y: trayView.center.y)
        trayCenterWhenDown = CGPoint(x: view.frame.size.width / 2, y: 625)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        
        let point = sender.location(in: view)
        switch (sender.state) {
        case .began:
            trayOriginalCenter = trayView.center
            break
        case .changed:
            let translationY = sender.translation(in: view).y

            if(trayOriginalCenter.y + translationY > (trayCenterWhenOpen?.y)!) {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translationY)
            }
            
            break
        case .ended:
            let velocity = sender.velocity(in: view)
            if(velocity.y > 0 ){
                trayView.center = trayCenterWhenDown!
            } else {
                trayView.center = trayCenterWhenOpen!
            }
            break
        default:
            break
        }
    }
    
    @IBAction func onMoveSmileFace(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        switch (sender.state) {
        case .began:
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFaceOriginalCenter = location
            newlyCreatedFace.center.y += trayView.frame.origin.y
            view.addSubview(newlyCreatedFace)
            break
        case .changed:
            let translationX = sender.translation(in: trayView).x
            let translationY = sender.translation(in: trayView).y
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translationX, y: newlyCreatedFaceOriginalCenter.y + translationY)
            break
        case .ended:
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanFace(sender:)))
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            break
        default:
            break
        }
    }
    
    func didPanFace(sender: UIPanGestureRecognizer) {
        
        
        let point = sender.location(in: view)
        switch (sender.state) {
        case .began:
            existingFaceOriginalCenter = point
            break
        case .changed:
            let translation = sender.translation(in: view)
            sender.view?.center = CGPoint(x: existingFaceOriginalCenter.x + translation.x, y: existingFaceOriginalCenter.y + translation.y)
            break
        case .ended:
            break
        default:
            break
        }
    }
}

