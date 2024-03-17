//
//  SingleQuoteTableViewCell.swift
//  Login
//
//  Created by 金成四 on 2024/03/17.
//

import UIKit

class SingleQuoteTableViewCell: UITableViewCell {
    // MARK: - outLet
    @IBOutlet weak var radioButtonImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var catgoryLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    // MARK: - variable
    var showMessage: UseQuote? {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let realShowMessage = showMessage else { return}
        authorLabel.text = realShowMessage.quoteMsg.author
        catgoryLabel.text = realShowMessage.quoteMsg.category
        quoteLabel.text = realShowMessage.quoteMsg.quote
        radioButtonImageView.image = UIImage(systemName: realShowMessage.isFaviorate ? "book.fill" : "book")
        
        let imageTapAction = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        radioButtonImageView.isUserInteractionEnabled = true
        radioButtonImageView.addGestureRecognizer(imageTapAction)
    }
    @objc func imageTap() {
        showMessage?.isFaviorate.toggle()
    }
    
}
