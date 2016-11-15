//
//  UILabel.swift
//  MBExtension
//
//  Created by WeiHuizhu on 16/7/14.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import UIKit

extension UILabel {
    /**
     自动适应屏幕高度。注意：在使用时，请先设置需要展示的内容及字体大小后在使用该方法
     */
    func autolayoutHeight(){
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.numberOfLines = 0
        self.height = (self.sizeThatFits(CGSize(width: self.width, height: CGFloat(MAXFLOAT)))).height
    }
}
