//
//  AlertCenter.swift
//  荷包君
//
//  Created by elijah tam on 2019/2/13.
//  Copyright © 2019 elijah tam. All rights reserved.
//

import Foundation
import UIKit


/// 警告中心
/// 可在app任何地方發送通知
class AlterCenter {
    static let singleton = AlterCenter()
    private init(){}
}

/// API
extension AlterCenter{
    func push_alert(message:String){
        if let current_view_controller = self.current_view_controller(){
            let alert = UIAlertController(title: NSLocalizedString("system", comment: ""), message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(
                UIAlertAction(title: NSLocalizedString("confirm", comment: ""),
                              style: .default, handler: nil)
            )
            current_view_controller.present(alert, animated: true, completion: nil)
        }
    }
}

/// Private
extension AlterCenter{
    /// 找到目前呈現的 viewcontroller
    private func current_view_controller() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
