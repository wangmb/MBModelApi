//
//  UITableView.swift
//  MBExtension
//
//  Created by WeiHuizhu on 16/7/15.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import UIKit

extension UITableView{
    /**
     滚动到Bottom
     
     - parameter animated: 动画，默认为true
     */
    func scrollToBottom(_ animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
