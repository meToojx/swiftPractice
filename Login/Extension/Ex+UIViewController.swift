//
//  Ex+UIViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/16.
//

import Foundation
import UIKit

extension UIViewController {
    // 加载视图的相关设定
    func showIndicatorView() {
        let commonmIndicatorView = UIActivityIndicatorView()
        // 加载视图的相关设定
        commonmIndicatorView.style = .large
        commonmIndicatorView.color = .blue
        commonmIndicatorView.center = self.view.center
        commonmIndicatorView.hidesWhenStopped = true
        commonmIndicatorView.tag = 999
        // 加载启动
        commonmIndicatorView.startAnimating()
        // 将加载视图添加到当前桌面
        self.view.addSubview(commonmIndicatorView)
        // 加载过程中使点击无效化
        self.view.isUserInteractionEnabled = false
    }
    
    func stopShowIndicatorView() {
        if let activeView = self.view.viewWithTag(999) as? UIActivityIndicatorView {
            activeView.stopAnimating()
            activeView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
}
