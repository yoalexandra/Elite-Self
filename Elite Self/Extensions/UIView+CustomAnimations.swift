//
//  UIView+CustomAnimations.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewWithFadeAnimation(_ view: UIView, duration: TimeInterval, options: UIView.AnimationOptions) {
        view.alpha = 0.0
        addSubview(view)
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
            view.alpha = 1.0
        }, completion: nil)
    }
    func removeSubviewWithTransform(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
            self.transform = CGAffineTransform(translationX: 0.0, y: -800)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    func removeSubview() {
        // use this when transitioning 
        self.removeFromSuperview()
    }
}
