//
//  MainChatListTableViewCell.swift
//  Login
//
//  Created by 金成四 on 2024/02/17.
//

import UIKit

class MainChatListTableViewCell: UITableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    // MARK: - Varibale
    var useData: WechatMessage? {
        didSet {
            setUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUI() {
        guard let realUseData = useData else { return}
        mainImage.image = UIImage(named: realUseData.imageString)
        mainImage.layer.cornerRadius = 10
        mainImage.layer.masksToBounds = true
        
        nameLabel.text = realUseData.name
        timeLabel.text = realUseData.time
        msgLabel.text = realUseData.chatMsg.last
    }

}
