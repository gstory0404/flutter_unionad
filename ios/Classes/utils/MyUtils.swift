//
//  MyUtils.swift
//  flutter_unionad
//
//  Created by 9Y on 2020/9/15.
//

import Foundation

class MyUtils{
    static func getVC() -> UIViewController {
            let viewController = UIApplication.shared.windows.filter { (w) -> Bool in
                w.isHidden == false
            }.first?.rootViewController
            return viewController!
        }
}

