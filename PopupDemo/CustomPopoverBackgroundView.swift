//
//  CustomPopoverBackgroundView.swift
//  PopupDemo
//
//  Created by Alex Truong on 4/13/17.
//  Copyright © 2017 Alex Truong. All rights reserved.
//

import UIKit

class CustomPopoverBackgroundView: UIPopoverBackgroundView {
    
    /*
    override class var wantsDefaultContentAppearance: Bool {
        return true
    }
    */
    
    override var arrowDirection: UIPopoverArrowDirection {
        get { return UIPopoverArrowDirection.left }
        set { }
    }
    
    override var arrowOffset: CGFloat {
        get { return 0.0 }
        set {}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        // blur effect view
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.layer.cornerRadius = 15.0
        blur.clipsToBounds = true
        
        self.addSubview(blur)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func arrowHeight() -> CGFloat {
        return 0.0
    }
    
    override class func arrowBase() -> CGFloat {
        return 0.0
    }
  
    override class func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 10.0
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
    }
}
