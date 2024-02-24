//
//  MeTableViewCell.swift
//  Login
//
//  Created by 金成四 on 2024/02/18.
//

import UIKit

class MeTableViewCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var showLabel: UILabel!
    
    var showData: MyPageMessage? {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let realuseMsg = showData else { return }
        headImage.image = UIImage(named: realuseMsg.imageString)
        showLabel.text = realuseMsg.showMsg
    }
    
}
