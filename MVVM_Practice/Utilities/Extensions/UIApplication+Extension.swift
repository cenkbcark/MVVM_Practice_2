//
//  UIApplication+Extension.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import Foundation
import UIKit

extension UIApplication {
    /// Finds and returns the top UIViewController for the given base.
    ///
    /// Note that if you did not provide base view controller, this function will return the top
    /// view controller for the current window of the app.
    /// - Parameters:
    ///    - base: Base view controller, it is the rootViewController of current window by default.
    /// - Returns: a CGFloat represents the width of the current string.
    public class func topViewController(base: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
