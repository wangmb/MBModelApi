//
//  Magic.swift
//
//  Created by WeiHuizhu on 2016/10/19.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import Foundation

/**
 - parameter object:   A textual representation of the object.
 - parameter file:     Defaults to the name of the file that called magic(). Do not override this default.
 - parameter function: Defaults to the name of the function within the file in which magic() was called. Do not override this default.
 - parameter line:     Defaults to the line number within the file in which magic() was called. Do not override this default.
 */
public func log_magic<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line)
{
    #if DEBUG //mb.wang增加宏、日志输出时间
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let filename = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
        print("\( dateFormatter.string(from: NSDate() as Date)) \(filename).\(function)[\(line)行]: \(object)\n", terminator: "")
    #endif
}
