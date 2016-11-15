//
//  ExString.swift
//  MBExtension
//
// 代码部分来源于网络
//  Created by WeiHuizhu on 16/7/14.
//  Copyright © 2016年 WeiHuizhu. All rights reserved.
//

import Foundation

extension String{
    
    //#pragma mark - 计算字体的高度，主要用于动态布局
    /**
     计算字体的高度，主要用于动态布局
     
     - parameter fontSize: 字体大小
     - parameter width:    显示宽
     
     - returns: 字体所占高度
     */
    func stringHeightWith(_ fontSize:CGFloat,width:CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text =  self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
    }
    
    
    /**
     正则匹配字符串
     
     - parameter pattern:    模式匹配
     - parameter ignoreCase: 是否区分大小写
     
     - returns: 返回匹配结果(as [NSTextCheckingResult])
     */
    func matches (_ pattern: String, ignoreCase: Bool = false) -> [NSTextCheckingResult]? {
        
        if let regex = regex(pattern, ignoreCase: ignoreCase) {
            //  Using map to prevent a possible bug in the compiler
            return regex.matches(in: self, options: [], range: NSMakeRange(0, length)).map { $0 }
        }
        
        return nil
    }
    
    internal func regex (_ pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
        
        var options = NSRegularExpression.Options.dotMatchesLineSeparators.rawValue
        
        if ignoreCase {
            options = NSRegularExpression.Options.caseInsensitive.rawValue | options
        }
        
        var error: NSError? = nil
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: options))
        } catch let error1 as NSError {
            error = error1
            regex = nil
        }
        
        return (error == nil) ? regex : nil
        
    }
    
    /**
     字符串替换
     
     - parameter what: 规则
     - parameter with: 替换的字符
     
     - returns: 新字符串
     */
    public func replace(_ what:String, with:String) -> String {
        let exp = try? NSRegularExpression(pattern: what, options: [])
        return exp!.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.length), withTemplate: with)
    }
    
    /**
     在字符串的给定位置插入字符串
     
     - parameter index:  插入字符串的位置
     - parameter string: 待插入的字符串
     
     - returns: 修改后的字符串
     */
    func insert(_ index:Int,_ string:String) -> String {
        if index > length {
            return self + string
        } else if index < 0 {
            return string + self
        }
        
        return self[0..<index] + string + self[index..<length]
    }
    
    /**
     获取两个字符串之间的值，未匹配返回nil
     
     - parameter left:  left String
     - parameter right: right String
     
     - returns: String or nil
     */
//    func between(_ left: String, _ right: String) -> String? {
//        guard let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards) , left != right && leftRange.upperBound != rightRange.lowerBound
//            else { return nil }
//        
//        return self[leftRange.endIndex...rightRange.startIndex.predecessor()]
//    }
    
    /**
     以驼峰的方式合并英文字符串。eg: os version -> osVersion
     
     - returns: String
     */
    func camelize() -> String {
        let source = clean(with: " ", allOf: "-", "_")
        if source.characters.contains(" ") {
            let first = source.substring(to: source.characters.index(source.startIndex, offsetBy: 1))
            let cammel = NSString(format: "%@", (source as NSString).capitalized.replacingOccurrences(of: " ", with: "", options: [], range: nil)) as String
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = (source as NSString).lowercased.substring(to: source.characters.index(source.startIndex, offsetBy: 1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    /**
     返回大写的字符串。EG:hello world -> Hello World
     
     - returns: String
     */
    func capitalize() -> String {
        return capitalized
    }
    
    /**
     判断某个字符串是否存在。
     
     - parameter substring: 字符串
     
     - returns: Bool
     */
    func contains(_ substring: String) -> Bool {
        return range(of: substring) != nil
    }
    
    /**
     去除控制符。eg:你  \t 好 \n\n\t！ -> 你 好 ！
     
     - returns: <#return value description#>
     */
    func collapseWhitespace() -> String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        return components.joined(separator: " ")
    }
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    /**
     某个字符在字符串中出现过多少次。
     
     - parameter substring: String
     
     - returns: Int
     */
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count-1
    }
    /**
     是否以某个字符串结尾。
     
     - parameter suffix: String
     
     - returns: Bool
     */
    func endsWith(_ suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    /**
     是否以某个字符串开始
     
     - parameter prefix: String
     
     - returns: Bool
     */
    func startsWith(_ prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    /**
     检查字符串左边是否包含某个字符串，没有则追加上
     
     - parameter prefix: String
     
     - returns: String
     */
    func ensureLeft(_ prefix: String) -> String {
        if startsWith(prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    /**
     检查字符串右边是否包含某个字符串，没有则追加上
     
     - parameter suffix: String
     
     - returns: String
     */
    func ensureRight(_ suffix: String) -> String {
        if endsWith(suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    /**
     字符串所在位置获取
     
     - parameter string:    字符串
     - parameter startFrom: 默认开始位置为0
     
     - returns: 字符串位置
     */
    func indexOf(_ string:String,startFrom:Int = 0)-> Int?{
        var str = self
        if startFrom != 0 {
            str = str.substring(startFrom, length: self.length)
        }
        let index = (str as NSString).range(of: string).location
        if index == NSNotFound {
            return nil
        }
        return index + startFrom
    }
    
    /**
     获取某个字符串最后一次出现的位置
     
     - parameter string: 字符串
     
     - returns: 字符串出现的位置
     */
//    func lastIndexOf(_ string: String) -> Int? {
//        if let index:Int = self.indexOf(string){
//            var lastIndex:Int = index
//            while (index != nil) {
//                let loopIndex:Int = self.indexOf(string, startFrom: index! + string.length)
//                if (loopIndex != nil) {
//                    index = loopIndex
//                    lastIndex = loopIndex
//                } else {
//                    index = nil
//                }
//            }
//            return lastIndex
//        } else {
//            return nil
//        }
//    }
    
    /**
     获取字符串中某个字符串所在的位置。
     
     - parameter substring: String
     
     - returns: Int
     */
    func indexOf(_ substring: String) -> Int? {
        if let range = range(of: substring) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        }
        return nil
    }
    /**
     字符串拼接
     
     - parameter strings: 字符串数组
     
     - returns: 拼接后的字符串
     */
    func concat(_ strings:String ...)->String{
        var out = self
        for str in strings {
            out += str
        }
        return out
    }
    /**
     英文/拼音的首字母。
     
     - returns: String
     */
//    func initials() -> String {
//        let words = self.components(separatedBy: " ")
//        return words.reduce(""){$0 + $1[0...0]}
//    }
    /**
     英文/拼音的首位字母。
     
     - returns: String
     */
//    func initialsFirstAndLast() -> String {
//        let words = self.components(separatedBy: " ")
//        return words.reduce("") { ($0 == "" ? "" : $0[0...0]) + $1[0...0]}
//    }
    /**
     是否只包含26个字母
     
     - returns: Bool
     */
    func isAlpha() -> Bool {
        for chr in characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    /**
     是否包含字母或数字
     
     - returns: Bool
     */
    func isAlphaNumeric() -> Bool {
        let alphaNumeric = CharacterSet.alphanumerics
        return components(separatedBy: alphaNumeric).joined(separator: "").length == 0
    }
    /**
     是否为空
     
     - returns: Bool
     */
    func isEmpty() -> Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0
    }
    /**
     是否为数字
     
     - returns: Bool
     */
    func isNumeric() -> Bool {
        if let _ = defaultNumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    /**
     数组转化为字符串。EG:",".join([1,2,3]) -> 1,2,3
     
     - parameter elements: S
     
     - returns: String
     */
    func join<S: Sequence>(_ elements: S) -> String {
        return elements.map{String(describing: $0)}.joined(separator: self)
    }
    
    /// 字符串长度
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    /**
     字符串转数组
     
     - parameter separator: 分隔字符串
     
     - returns: 数组[String]
     */
    func split(_ separator:String) -> [String] {
        return self.components(separatedBy: separator)
    }
    
    func times(_ n: Int) -> String {
        return (0..<n).reduce("") { $0.0 + self }
    }
    
    mutating func toHex()->UInt32?{
        if self.startsWith("#") {
            self = self.substring(from: self.characters.index(self.startIndex, offsetBy: 1))
        }
        
        var hexNum:UInt32 = 0x0
        let scanner = Scanner.localizedScanner(with: self)
        guard !(scanner as AnyObject).scanHexInt32(&hexNum) else{ return nil}
        
        return hexNum
    }
    
    /**
     转化为Float，转化失败返回nil
     
     - returns: Float
     */
    func toFloat() -> Float? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.floatValue
        }
        return nil
    }
    
    /**
     转化为Int，转化失败返回nil
     
     - returns: Int
     */
    func toInt() -> Int? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }
    /**
     转化为Double,转化失败返回nil
     
     - parameter locale:
     
     - returns: Double
     */
    func toDouble(_ locale: Locale = Locale.current) -> Double? {
        let nf = localeNumberFormatter(locale)
        
        if let number = nf.number(from: self) {
            return number.doubleValue
        }
        return nil
    }
    /**
     转化为Bool,转化失败返回nil
     
     - returns: Bool
     */
    func toBool() -> Bool? {
        let trimmed = self.trimmed().lowercased()
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    /**
     转化为date，转化失败返回nil
     
     - parameter format: 默认格式yyyy-MM-dd
     
     - returns: NSDate
     */
    func toDate(_ format: String = "yyyy-MM-dd") -> Date? {
        return dateFormatter(format).date(from: self)
    }
    /**
     转化为DateTime，转化失败返回nil
     
     - parameter format: 默认格式yyyy-MM-dd HH:mm:ss
     
     - returns: NSDate
     */
    func toDateTime(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        return toDate(format)
    }
    /**
     去除左空格
     
     - returns: String
     */
    func trimmedLeft() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted) {
            return self[range.lowerBound..<endIndex]
        }
        return self
    }
    /**
     去除右空格
     
     - returns: String
     */
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted, options: NSString.CompareOptions.backwards) {
            return self[startIndex..<range.upperBound]
        }
        return self
    }
    /**
     去除左右空格
     
     - returns: String
     */
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    /**
     获取字符串中的某个子字符串。EG:"hello world"[0...1] ->"he"
     
     - parameter r: Range
     
     - returns: String
     */
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            return self[startIndex..<endIndex]
        }
    }
    /**
     获取字符串中某个子字符串。
     
     - parameter startIndex: 开始位置
     - parameter length:     获取长度
     
     - returns: <#return value description#>
     */
    func substring(_ startIndex: Int, length: Int) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.characters.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    //
    
    fileprivate enum ThreadLocalIdentifier {
        case dateFormatter(String)
        
        case defaultNumberFormatter
        case localeNumberFormatter(Locale)
        
        var objcDictKey: String {
            switch self {
            case .dateFormatter(let format):
                return "SS\(self)\(format)"
            case .localeNumberFormatter(let l):
                return "SS\(self)\(l.identifier)"
            default:
                return "SS\(self)"
            }
        }
    }
    
    fileprivate func threadLocalInstance<T: AnyObject>(_ identifier: ThreadLocalIdentifier, initialValue: @autoclosure () -> T) -> T {
        let storage = Thread.current.threadDictionary
        let k = identifier.objcDictKey
        
        let instance: T = storage[k] as? T ?? initialValue()
        if storage[k] == nil {
            storage[k] = instance
        }
        
        return instance
    }
    
    fileprivate func dateFormatter(_ format: String) -> DateFormatter {
        return threadLocalInstance(.dateFormatter(format), initialValue: {
            let df = DateFormatter()
            df.dateFormat = format
            return df
            }())
    }
    
    fileprivate func defaultNumberFormatter() -> NumberFormatter {
        return threadLocalInstance(.defaultNumberFormatter, initialValue: NumberFormatter())
    }
    
    fileprivate func localeNumberFormatter(_ locale: Locale) -> NumberFormatter {
        return threadLocalInstance(.localeNumberFormatter(locale), initialValue: {
            let nf = NumberFormatter()
            nf.locale = locale
            return nf
            }())
        
    }
}
