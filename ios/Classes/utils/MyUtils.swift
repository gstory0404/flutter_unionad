//
//  MyUtils.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/15.
//

import Foundation

class MyUtils{
    static func getVC() -> UIViewController {
        let vc = UIApplication.shared.delegate?.window??.rootViewController
        if let vc = vc  {
            return findBestViewController(vc: vc)
        }
        return UIViewController.init()
    }
    
    class func findBestViewController(vc : UIViewController) -> UIViewController {
        
        if vc.presentedViewController != nil {
            return findBestViewController(vc: vc.presentedViewController!)
        } else if vc.isKind(of:UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count > 0 {
                return findBestViewController(vc: svc.viewControllers.last!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let nvc = vc as! UINavigationController
            if nvc.viewControllers.count > 0 {
                return findBestViewController(vc: nvc.topViewController!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let tvc = vc as! UITabBarController
            if (tvc.viewControllers?.count)! > 0 {
                return findBestViewController(vc: tvc.selectedViewController!)
            } else {
                return vc
            }
        } else {
            return vc
        }
    }
    
    //获取屏幕尺寸
    static func getScreenSize() -> CGRect {
        let screenBounds:CGRect = UIScreen.main.bounds
        return screenBounds
    }
}

