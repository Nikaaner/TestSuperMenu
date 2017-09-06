//
//  UIColor.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 06.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255,
                  green: CGFloat((hex >> 8) & 0xFF) / 255,
                  blue: CGFloat(hex & 0xFF) / 255,
                  alpha: alpha)
    }
    
    convenience init(hexWithAlpha: UInt64) {
        self.init(red: CGFloat((hexWithAlpha >> 24) & 0xFF) / 255,
                  green: CGFloat((hexWithAlpha >> 16) & 0xFF) / 255,
                  blue: CGFloat((hexWithAlpha >> 8) & 0xFF) / 255,
                  alpha: CGFloat(hexWithAlpha & 0xFF) / 255)
    }
    
}

// MARK: - Style

extension UIColor {
    
    static let flamingo = UIColor(hex: 0xF04541)
    
}
