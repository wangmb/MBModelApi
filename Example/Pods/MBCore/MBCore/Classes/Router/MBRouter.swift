//
//  MBRouter.swift
//  Pods
//
//  Created by WeiHuizhu on 2016/10/24.
//
//

import Foundation


public enum MBRouterError:Error{
    case schemeNotExisted
    case bundleExecutableField
    case classNotExisted
    case methodNotExisted
}

extension MBRouterError:CustomStringConvertible,CustomDebugStringConvertible{
    public var description:String{
        switch self {
        case .schemeNotExisted:
            return "schemeNotExisted"
        default:
            return "ssss"
        }
    }
    public var debugDescription:String{
        return description
    }
}

open class MBRouter:NSObject{
    open static let sharedInstance:MBRouter = MBRouter()
    
    /**
     APP之间调用
     
     - parameter url: 访问的url（如app间调用）
     
     - parameter NSDictionary: 字符串
     
     - returns: AnyObject
     */
    open func routeURL(url:NSURL,completion:NSDictionary) throws -> AnyObject?{
        guard url.scheme != "" else {
            return nil
        }
        
        let params:NSMutableDictionary = NSMutableDictionary()
        if let urlString = url.query {
            for param:String in urlString.components(separatedBy: "&"){
                let kv = param.components(separatedBy: "=")
                guard kv.count < 2  else {
                    continue
                }
                
                params.setValue(kv[1], forKey: kv[0])
            }
        }
        
        //加强url判断
        
        /// TODO 待完善
        let action:String = ""//(url.path?.replace("/", with: ""))!
        
        guard action.hasSuffix("native") else {
            return nil
        }
        
        return try self.routeAction(targetName: url.host!, actionName: action, params: params)
    }
    
    /**
     模块之间相互调用
     
     - parameter targetName: 类名
     
     - parameter actionName: 方法名
     
     - parameter params: 调用参数
     
     - returns: AnyObject
     */
    open func routeAction(targetName:String,actionName:String,params:NSDictionary?=nil) throws -> AnyObject?{
        let targetClassStr = "Target_\(targetName)"
        //swift 中会将swift对应的方法编译为类OC方法估需要增加参数名
        let actionStr = params == nil ? "Action_\(actionName)":"Action_\(actionName)WithParams:"
        
        //获取命名空间
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            log_magic("命名空间获取失败！")
            throw MBRouterError.bundleExecutableField
        }
        //获取命名空间和类名转换成类
        guard let targetClass = NSClassFromString((clsName as! String)+"."+targetClassStr) as? NSObject.Type else {
            log_magic("\(clsName)中\(targetClassStr)类不存在")
            throw MBRouterError.classNotExisted
        }
        
        let target = targetClass.init()
        let action:Selector = NSSelectorFromString(actionStr)
        
        if target.responds(to: action){//判断调用方法是否存在
            log_magic("调用\(targetClassStr)类中\(actionStr)方法")
            return target.perform(action, with: params).takeUnretainedValue()
        }else{//调用方法不存在
            log_magic("\(targetClassStr)类中不存在\(actionStr)方法")
            throw MBRouterError.methodNotExisted
        }
    }
    
    fileprivate func getValueByKey(obj:AnyObject, key: String) -> Any {
        let hMirror = Mirror(reflecting: obj)
        for case let (label?, value) in hMirror.children {
            if label == key {
                return unwrap(any: value)
            }
        }
        return NSNull()
    }
    //将可选类型（Optional）拆包
    fileprivate func unwrap(any:Any) -> Any {
        let mi = Mirror(reflecting: any)
        
        if mi.displayStyle != .optional {
            return any
        }
        if mi.children.count == 0 { return any }
        let (_, some) = mi.children.first!
        return some
    }
}
