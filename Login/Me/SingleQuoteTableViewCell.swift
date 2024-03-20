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
    
    var delegate: QutoDelegate?
    // MARK: - variable
    var showMessage: UseQuote? {
        didSet {
            setUI()
        }
    }
    var index: Int = 0
    func setUI() {
        self.backgroundColor = UIColor(named: "customBackColor")
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
        // bool 自动转换为相反的类型
        showMessage?.isFaviorate.toggle()
        delegate?.changeData(index: index)
    }
    
}
