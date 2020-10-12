//
//  LogUtil.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/11.
//

import Foundation

public class LogUtil : NSObject{
   
    static let logInstance = LogUtil()
    
    private var isDebug: Bool?
    
    func isShow(debug:Bool){
        self.isDebug = debug
    }
    
    func printLog<T>(message: T,
                     file: String = #file,
                     method: String = #function,
                     line: Int = #line)
    {
        if(self.isDebug!){
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        }
    }
}
