//
//  UIView.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 06.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

extension UIView {
    
    private static var activityIndicatorAssociatedKey = "activityIndicatorAssociatedKey"
    
    private var activityIndicator: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &UIButton.activityIndicatorAssociatedKey) as? UIActivityIndicatorView
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &UIButton.activityIndicatorAssociatedKey, newValue as UIActivityIndicatorView?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    private var newActivityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = UIColor.black
        return activityIndicator
    }
    
    var isActive: Bool {
        get {
            return isUserInteractionEnabled
        }
        set {
            isUserInteractionEnabled = newValue
            alpha = newValue ? 1 : 0.9
        }
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.isActive = false
            self.activityIndicator = self.newActivityIndicator
            self.activityIndicator!.startAnimating()
            self.activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
            self.superview?.addSubview(self.activityIndicator!)
            
            let centerY = NSLayoutConstraint(item: self.activityIndicator!,
                                             attribute: NSLayoutAttribute.centerY,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: self,
                                             attribute: NSLayoutAttribute.centerY,
                                             multiplier: 1,
                                             constant: 0)
            self.superview?.addConstraint(centerY)
            
            let centerX = NSLayoutConstraint(item: self.activityIndicator!,
                                             attribute: NSLayoutAttribute.centerX,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: self,
                                             attribute: NSLayoutAttribute.centerX,
                                             multiplier: 1,
                                             constant: 0)
            self.superview?.addConstraint(centerX)
        }
    }
    
    func hideActivityIndicator(andActivate activate: Bool = true) {
        DispatchQueue.main.async {
            self.isActive = activate
            guard let activityIndicator = self.activityIndicator else { return }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
