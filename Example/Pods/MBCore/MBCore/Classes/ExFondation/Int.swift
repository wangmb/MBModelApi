//
//  Int.swift
//  MBExtension
//
//  Created by WeiHuizhu on 16/7/15.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import Foundation

extension Int {
    /**
     Hex转化为HexString.eg:0xff8942.toHexString()
     
     - returns: String
     */
    public func toHexString()->String{
        var hexString = String(format: "%2X", self)
        let leadingZerosString = String(repeating: "0", count: 6 - hexString.characters.count)
        hexString = leadingZerosString + hexString
        return hexString
    }
}
