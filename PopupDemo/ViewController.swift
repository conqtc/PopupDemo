//
//  ViewController.swift
//  PopupDemo
//
//  Created by Alex Truong on 4/13/17.
//  Copyright © 2017 Alex Truong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var statusBarHidden = false
    
    lazy var slideInTransitioningDelegate = SlideInTransitioningDelegate(direction: .left, animation: .animationStretchThenShrink)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MenuTableViewController {
            controller.delegate = self
        
            switch (segue.identifier!) {
            case "LeftMenuSegue":
                slideInTransitioningDelegate.direction = .left
                slideInTransitioningDelegate.animation = .animationStretchThenShrink
            case "RightMenuSegue":
                slideInTransitioningDelegate.direction = .right
                slideInTransitioningDelegate.animation = .animationDefault
            case "TopMenuSegue":
                slideInTransitioningDelegate.direction = .top
                slideInTransitioningDelegate.animation = .animationSpringWithDamping
            case "BottomMenuSegue":
                slideInTransitioningDelegate.direction = .bottom
                slideInTransitioningDelegate.animation = .animationStretchThenShrink
            default:
                break
            }

            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
            
            if segue.identifier != "BottomMenuSegue" {
                //updateStatusBar(hidden: true)
            }
        } else if segue.identifier == "LeftMenuSegue" {
            let controller = segue.destination
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
        } else {
            if let popover = segue.destination.popoverPresentationController {
                popover.delegate = self
                if let source = sender as? UIView {
                    popover.sourceRect = source.bounds
                }
                //popover.popoverBackgroundViewClass = CustomPopoverBackgroundView.self
            }
        }
    }
}

// MARK: status bar handling
extension ViewController {
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    func updateStatusBar(hidden: Bool) {
        if statusBarHidden != hidden {
            statusBarHidden = hidden
            UIView.animate(withDuration: 0.25) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
}

// MARK: delegation
extension ViewController: MenuTableDelegate {
    func menuTable(sender: UIViewController, didSelectWithObject object: AnyObject?) {
        updateStatusBar(hidden: false)
    }
}

// MARK: Adaptive
extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
