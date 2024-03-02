//
//  FriendTableViewCell.swift
//  Login
//
//  Created by 金成四 on 2024/02/24.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var friendHeadImage: UIImageView!
    @IBOutlet weak var friendGender: UILabel!
    @IBOutlet weak var friendName: UILabel!
    
    var mainMsg: FriendMsg? {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let useMainMsg = mainMsg else { return }
        friendHeadImage.image = UIImage(data: useMainMsg.imageUrlData)
        friendGender.text = useMainMsg.gender
        friendName.text = useMainMsg.name
    }
}
