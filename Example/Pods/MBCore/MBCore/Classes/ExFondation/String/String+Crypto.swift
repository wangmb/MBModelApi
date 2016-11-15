//
//  String+Security.swift
//  MBExtension
//
//  Created by WeiHuizhu on 16/7/14.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import Foundation
//import CommonCrypto

//需要引入 #import <CommonCrypto/CommonCrypto.h>
extension String{
    enum StringCryptorError: Error {
        case missingIV
        case cryptOperationFailed
        case wrongInputData
        case unknownError
    }
    
    /**
     MD5加密
     
     - returns: String
     */
//    func md5()->String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deallocate(capacity: digestLen)
//        return String(format: hash as String)
//    }
    
    /**
     3DES加密
     
     - parameter key: 加密KEY
     
     - parameter iv: iv buffer。最多允许设置8个字符
     
     - throws: StringCryptorError
     
     - returns: String
     */
//    func encodeTo3DES(_ key:String,iv:String = "12345678") throws -> String{
//        // Prepare data parameters
//        let keyData: Data! = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
////        let keyBytes         =  keyData.bytes.bindMemory(to: Void.self, capacity: keyData.count)
//        let keyBytes = NSData(data: keyData).bytes.bindMemory(to: Void.self, capacity: keyData.count)
//        
//        let data = self.data(using: String.Encoding.utf8)
//        let operation: CCOperation = UInt32(kCCEncrypt)
//        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
//        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
//        let keyLength        = size_t(kCCKeySize3DES)
//        
//        let dataLength       = Int(data!.count)
//        let dataBytes        = (data! as NSData).bytes.bindMemory(to: Void.self, capacity: data!.count)
//        let bufferData       = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
//        let bufferPointer    = bufferData.mutableBytes
//        let bufferLength     = size_t(bufferData.length)
//        let ivBuffer         =  ((iv.data(using: String.Encoding.utf8))! as NSData).bytes.bindMemory(to: Void.self, capacity: (iv.data(using: String.Encoding.utf8))!.count)//== nil ? nil : UnsafePointer<Void>(iv!.bytes)
//        var bytesDecrypted   = Int(0)
//        // Perform operation
//        let cryptStatus = CCCrypt(
//            operation,                  // Operation
//            algoritm,                   // Algorithm
//            options,                    // Options
//            keyBytes,                   // key data
//            keyLength,                  // key length
//            ivBuffer,                   // IV buffer
//            dataBytes,                  // input data
//            dataLength,                 // input length
//            bufferPointer,              // output buffer
//            bufferLength,               // output buffer length
//            &bytesDecrypted)            // output bytes decrypted real length
//        if Int32(cryptStatus) == Int32(kCCSuccess) {
//            bufferData.length = bytesDecrypted // Adjust buffer size to real bytes
//            return (bufferData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)).replace(" ", with: "")
//        } else {
////            log_magic("Error in 3des operation: \(cryptStatus)")
//            throw(StringCryptorError.cryptOperationFailed)
//        }
//    }
    /**
     3DES解码
     
     - parameter key: KEY
     
     - parameter iv: iv buffer。最多允许设置8个字符
     
     - throws: StringCryptorError
     
     - returns: String
     */
//    func decodeFrom3DESEncoding(_ key:String,iv:String = "12345678") throws -> String? {
//        // Prepare data parameters
//        let keyData: Data! = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
////        let keyBytes         = keyData.bytes.bindMemory(to: Void.self, capacity: keyData.count)
//        let keyBytes = NSData(data: keyData).bytes.bindMemory(to: Void.self, capacity: keyData.count)
//
//        
//        let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions())
//        let operation: CCOperation = UInt32(kCCDecrypt)
//        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
//        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
//        let keyLength        = size_t(kCCKeySize3DES)
//        
//        let dataLength       = Int(data!.count)
//        let dataBytes        = (data! as NSData).bytes.bindMemory(to: Void.self, capacity: data!.count)
//        let bufferData       = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
//        let bufferPointer    = bufferData.mutableBytes
//        let bufferLength     = size_t(bufferData.length+kCCBlockSize3DES)
//        let ivBuffer         =  ((iv.data(using: String.Encoding.utf8))! as NSData).bytes.bindMemory(to: Void.self, capacity: (iv.data(using: String.Encoding.utf8))!.count)//== nil ? nil : UnsafePointer<Void>(iv!.bytes)
//        var bytesDecrypted   = Int(0)
//        // Perform operation
//        let cryptStatus = CCCrypt(
//            operation,                  // Operation
//            algoritm,                   // Algorithm
//            options,                    // Options
//            keyBytes,                   // key data
//            keyLength,                  // key length
//            ivBuffer,                   // IV buffer
//            dataBytes,                  // input data
//            dataLength,                 // input length
//            bufferPointer,              // output buffer
//            bufferLength,               // output buffer length
//            &bytesDecrypted)            // output bytes decrypted real length
//        if Int32(cryptStatus) == Int32(kCCSuccess) {
//            bufferData.length = bytesDecrypted // Adjust buffer size to real bytes
//            return String(data: bufferData as Data, encoding: String.Encoding.utf8)
//        } else {
////            log_magic("Error in 3des operation: \(cryptStatus)")
//            throw(StringCryptorError.cryptOperationFailed)
//        }
//    }
    
    /**
     字符串转化为base64编码
     
     - returns: base64编码
     */
    func encodeToBase64Encoding()->String!{
        let utf8str = self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        return utf8str.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    /**
     base64编码转化为字符串
     
     - returns: 字符串
     */
    func decodeFromBase64Encoding()->String!{
        let base64data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        return NSString(data: base64data!, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    /**
     编码
     
     - returns: <#return value description#>
     */
    func encodedURL() -> String? {
        //        var customAllowedSet =  NSCharacterSet.URLQueryAllowedCharacterSet()
        //        var escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    /**
     解码
     
     - returns: URL解码
     */
    func decodeURL() -> String! {
        let str:NSString = self as NSString
        return str.replacingPercentEscapes(using: String.Encoding.utf8.rawValue)
    }
    /**
     将参数信息转化为get参数格式
     
     - parameter parameters: 参数
     
     - returns: <#return value description#>
     */
    static func queryStringFromParameters(_ parameters: Dictionary<String,String>) -> String? {
        if (parameters.count == 0)
        {
            return nil
        }
        var queryString : String? = nil
        for (key, value) in parameters {
            if let encodedKey = key.encodedURL() {
                if let encodedValue = value.encodedURL() {
                    if queryString == nil
                    {
                        queryString = "?"
                    }
                    else
                    {
                        queryString! += "&"
                    }
                    queryString! += encodedKey + "=" + encodedValue
                }
            }
        }
        return queryString
    }
}
