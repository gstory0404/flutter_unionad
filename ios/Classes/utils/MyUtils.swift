//
//  MyUtils.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/15.
//

import Foundation

class MyUtils{
    static func getVC() -> UIViewController {
            let viewController = UIApplication.shared.windows.filter { (w) -> Bool in
                w.isHidden == false
            }.first?.rootViewController
            return viewController!
        }
    
    //获取屏幕尺寸
    static func getScreenSize() -> CGRect {
        let screenBounds:CGRect = UIScreen.main.bounds
        return screenBounds
    }
}

