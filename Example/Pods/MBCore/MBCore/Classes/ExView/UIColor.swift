//
//  UIColor.swift
//  MBExtension
//
//  Created by WeiHuizhu on 16/7/14.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import UIKit

extension UIColor {
    //初始化方式：UIColor(hex: 0xFFC0CB)
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    class func PinkWebColor() -> UIColor {
        return UIColor(hex: 0xFFC0CB)
    }

}
