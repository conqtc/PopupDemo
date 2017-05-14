//
//  SlideInAnimationController.swift
//  PopupDemo
//
//  Created by Alex Truong on 4/13/17.
//  Copyright © 2017 Alex Truong. All rights reserved.
//

import UIKit

class SlideInAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let stretchScale: CGFloat = 1.05
    let shrinkScale: CGFloat = 0.995
    
    let direction: SlideInDirection
    let animation: SlideInAnimation
    
    init(direction: SlideInDirection = .left, animation: SlideInAnimation = .animationDefault) {
        self.direction = direction
        self.animation = animation

        super.init()
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        // add "to" view to the container
        let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        container.addSubview(to.view)
        
        // calculate start frame and end frame
        let endFrame = transitionContext.finalFrame(for: to)
        var startFrame = endFrame
        
        switch (direction) {
        case .left:
            startFrame.origin.x = -endFrame.width
        case .right:
            startFrame.origin.x = container.frame.size.width
        case .top:
            startFrame.origin.y = -endFrame.height
        case .bottom:
            startFrame.origin.y = container.frame.size.height
        }
        
        // scale factors
        var scaleX: CGFloat = 1.0
        var scaleY: CGFloat = 1.0
        var shrinkScaleX: CGFloat = 1.0
        var shrinkScaleY: CGFloat = 1.0

        if animation == .animationStretchThenShrink {
            switch (direction) {
            case .left:
                (scaleX, shrinkScaleX) = (stretchScale, shrinkScale)
                to.view.layer.anchorPoint.x = 0.0
            case .right:
                (scaleX, shrinkScaleX) = (stretchScale, shrinkScale)
                to.view.layer.anchorPoint.x = 1.0
            case .top:
                (scaleY, shrinkScaleY) = (stretchScale, shrinkScale)
                to.view.layer.anchorPoint.y = 0.0
            case .bottom:
                (scaleY, shrinkScaleY) = (stretchScale, shrinkScale)
                to.view.layer.anchorPoint.y = 1.0
            }
        }
        
        // start animation
        to.view.frame = startFrame
        to.view.alpha = 0.0
        let duration = transitionDuration(using: transitionContext)
        
        switch (animation) {
        case .animationDefault:
            UIView.animate(withDuration: duration, animations: {
                to.view.frame = endFrame
                to.view.alpha = 1.0
            }) { didComplete in
                transitionContext.completeTransition(didComplete)
            }

        case .animationSpringWithDamping:
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                to.view.frame = endFrame
                to.view.alpha = 1.0
            }) { didComplete in
                transitionContext.completeTransition(didComplete)
            }
        
        case .animationStretchThenShrink:
            let stretchTime: Double = 1/2
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: stretchTime, animations: {
                    to.view.frame = endFrame
                    to.view.alpha = 1.0
                    to.view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                })

                UIView.addKeyframe(withRelativeStartTime: stretchTime, relativeDuration: (1 - stretchTime), animations: {
                    to.view.transform = CGAffineTransform(scaleX: shrinkScaleX, y: shrinkScaleY)
                })
            }) { didComplete in
                to.view.transform = CGAffineTransform.identity
                transitionContext.completeTransition(didComplete)
            }
        }
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        switch (animation) {
        case .animationDefault:
            return 0.2
        case .animationStretchThenShrink:
            return 0.3
        case .animationSpringWithDamping:
            return 0.3
        }
    }

}
