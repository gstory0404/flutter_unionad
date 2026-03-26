//
//  MyUtils.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/15.
//

import Foundation
import UIKit

class MyUtils{
    static func getVC() -> UIViewController {
        let appDelegateRoot = UIApplication.shared.delegate?.window??.rootViewController
        var keyWindowRoot: UIViewController? = nil
        var legacyWindowRoot: UIViewController? = nil

        if #available(iOS 13.0, *) {
            let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
            let windows = windowScenes.flatMap { $0.windows }
            keyWindowRoot = windows.first(where: { $0.isKeyWindow })?.rootViewController
            if keyWindowRoot == nil {
                keyWindowRoot = windows.first(where: { !$0.isHidden && $0.windowLevel == .normal })?.rootViewController
            }

            // 兼容未启用 UIScene 或旧生命周期项目：回退到 legacy windows。
            if keyWindowRoot == nil {
                let legacyWindows = UIApplication.shared.windows
                legacyWindowRoot = legacyWindows.first(where: { $0.isKeyWindow })?.rootViewController
                if legacyWindowRoot == nil {
                    legacyWindowRoot = legacyWindows.first(where: { !$0.isHidden && $0.windowLevel == .normal })?.rootViewController
                }
            }
        }

        if let vc = appDelegateRoot ?? keyWindowRoot ?? legacyWindowRoot {
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
