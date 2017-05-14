//
//  SlideInPresentationController.swift
//  PopupDemo
//
//  Created by Alex Truong on 4/13/17.
//  Copyright © 2017 Alex Truong. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    
    var shadow: UIView!
    
    let direction: SlideInDirection
    
    init(direction: SlideInDirection, presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        self.direction = direction
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupShadow()
    }
    
    func setupShadow() {
        shadow = UIView()
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        shadow.alpha = 0.0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(shadowTapped(recognizer:)))
        shadow.addGestureRecognizer(gesture)
    }
    
    dynamic func shadowTapped(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let childSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        
        var childFrame = CGRect(x: 0, y: 0, width: childSize.width, height: childSize.height)
        
        switch (direction) {
        case .right:
            childFrame.origin.x = containerView!.bounds.size.width - childSize.width
        case .bottom:
            childFrame.origin.y = containerView!.bounds.size.height - childSize.height
        default:
            break
        }

        return childFrame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        switch (direction) {
        case .left, .right:
            return CGSize(width: parentSize.width * 0.75, height: parentSize.height)
        case .top, .bottom:
            var height = parentSize.height * 0.75
            if let tableView = presentedView as? UITableView {
                tableView.layoutIfNeeded()
                if height > tableView.contentSize.height {
                    height = tableView.contentSize.height
                }
            }
            return CGSize(width: parentSize.width, height: height)
        }
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(shadow, at: 0)

        // stressing the view constraints
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[shadow]|", options: [], metrics: nil, views: ["shadow": shadow]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[shadow]|", options: [], metrics: nil, views: ["shadow": shadow]))
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.shadow.alpha = 1.0
            })
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.shadow.alpha = 0.0
            }) { _ in
                self.shadow.removeFromSuperview()
            }
        }
    }
}
