//
//  AddressBookActions.swift
//  Pods
//
//  Created by WeiHuizhu on 2016/11/11.
//
//

import Foundation
import UIKit
import MBCore

// MARK: - 通讯录公共接口扩展
extension MBRouter{
    
    /// 进入个人详情界面
    ///
    /// - Parameter user_id: 用户唯一标识
    /// - Returns: UIViewController
    open func MBRouter_toAddressBookDetailViewController(user_id:String) -> UIViewController{
        let viewController = try! self.routeAction(targetName: "A", actionName: "DetailViewController", params: ["user_id":user_id])
        
        return viewController != nil && viewController!.isKind(of: UIViewController.self) ? viewController as! UIViewController : UIViewController()
        
    }
    
    open func MBRouter_ToDemoMobuleADetailViewController() -> UIViewController {
        var viewController:AnyObject? = nil
        do{
            viewController = try routeAction(targetName: "B", actionName: "BViewController")
        }catch {
            log_magic("\(error)  "+error.localizedDescription)
        }
        
        return viewController != nil && viewController!.isKind(of: UIViewController.self) ? viewController as! UIViewController : UIViewController()
    }
}
