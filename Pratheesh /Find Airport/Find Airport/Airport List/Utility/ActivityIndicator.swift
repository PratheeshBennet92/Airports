//
//  BaseViewController.swift
//  Find Airport
//
//  Created by 1722885 on 29/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//


import UIKit
class ActivityIndicator: UIView {
    // MARK: - Propery Declaration
    var activityIndicator: UIActivityIndicatorView?
    var textLabel: UILabel?
    var title: String?
    let bgViewAlpha: CGFloat = 0.5
    
    // MARK: - Spinner Animations
    func displaySpinner(onView: UIView, title: String?) {
        self.stopAnimating()
        self.frame = onView.frame
        self.backgroundColor = UIColor.black.withAlphaComponent(bgViewAlpha)
        textLabel = UILabel(frame: CGRect(x: (self.bounds.width/2) - CGFloat(spinnerLeading), y: (self.bounds.height/2) + CGFloat(spinnerTop), width: CGFloat(spinnerWidth), height: CGFloat(spinnerHeight)))
        textLabel?.textColor = UIColor.white
        textLabel?.text = title
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator?.center = self.center
        self.addSubview(activityIndicator!)
        onView.addSubview(self)
        onView.addSubview(textLabel!)
        startAnimating()
    }
    
    func startAnimating() {
        activityIndicator?.startAnimating()
    }
    
    func stopAnimating() {
        textLabel?.removeFromSuperview()
        activityIndicator?.stopAnimating()
        self.removeFromSuperview()
    }
}
