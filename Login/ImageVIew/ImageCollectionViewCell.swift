//
//  ImageCollectionViewCell.swift
//  Login
//
//  Created by 金成四 on 2024/03/03.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setUI() {
//        showImage.translatesAutoresizingMaskIntoConstraints = false
//        showImage.frame.size.height = self.contentView.frame.height - 30
    }
}
