//
//  UIView.swift
//  MBExtension
//
//  Created by WeiHuizhu on 16/7/14.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T {
        let v: T? = fromNib(nibNameOrNil)
        return v!
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = "\(T.self)".components(separatedBy: ".").last!
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
}
// MARK: - 提示信息扩展
extension UIView{
    /**
     水平居中
     
     - parameter parentWidth: 父视图width
     */
    func centerHorizontally(_ parentWidth: CGFloat) {
        //如果参数是小数，则求最大的整数但不大于本身
        let centerX = CGFloat(floor(Double(CGFloat(parentWidth - self.width) / CGFloat(2.0))))
        self.frame = CGRect(x:centerX, y:self.y, width:self.width, height:self.height)
    }
    
    var isIPhone5:Bool {
        get{
            return fabs(Double(UIScreen.main.bounds.size.height)-Double(568)) < DBL_EPSILON
        }
    }
    
    //#pragma mark - alert
    class func showAlertView(_ title:String="提示信息",message:String)
    {
        
//        let alerts = UIAlertController(title: title, message: message, preferredStyle: .Alert)
//        alerts.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil)
        
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: "确定")
        alert.show()
        
    }
}
// MARK: - 布局扩展
extension UIView  {
    /// UIView X
    public var x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set(value){
            var rect:CGRect = self.frame
            rect.origin.x = value
            self.frame = rect
        }
    }
    
    public var y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set(value){
            var rect:CGRect = self.frame
            rect.origin.y = value
            self.frame = rect
        }
    }
    
    public var right:CGFloat {
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set(value){
            var rect:CGRect = self.frame
            rect.origin.x = value - rect.size.width
            self.frame = rect
        }
    }
    
    public var bottom:CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set(value){
            var rect:CGRect = self.frame
            rect.origin.y = value - rect.size.height
            self.frame = rect
        }
    }
    
    public var width:CGFloat{
        get{
            return self.frame.size.width
        }
        set(value){
            var rect:CGRect = self.frame
            rect.size.width = value
            self.frame = rect
        }
    }
    
    public var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set(value){
            var rect:CGRect = self.frame
            rect.size.height = value
            self.frame = rect}
    }
    
    public var centerX: CGFloat {
        get {
            return self.x+self.width/2
        }
        set(value) {
            var rect = self.frame
            rect.origin.x = value - self.width/2
            self.frame = rect
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.y+self.height/2
        }
        set(value) {
            var rect = self.frame
            rect.origin.y = value - self.height/2
            self.frame = rect
        }
    }
    
}
