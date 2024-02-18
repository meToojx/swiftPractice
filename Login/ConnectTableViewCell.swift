//
//  ConnectTableViewCell.swift
//  Login
//
//  Created by 金成四 on 2024/02/17.
//

import UIKit

class ConnectTableViewCell: UITableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var statuseButton: UIButton!

    // MARK: - Function
    func setUI() {
        self.selectionStyle = .none
        // 图片圆角
        headImage.layer.cornerRadius = 8
        headImage.layer.masksToBounds = true
        // 按键边框
        statuseButton.layer.borderWidth = 1
        statuseButton.layer.borderColor = UIColor.gray.cgColor
        // 按键圆角
        statuseButton.layer.cornerRadius = 10
        statuseButton.layer.masksToBounds = true
    }
}
