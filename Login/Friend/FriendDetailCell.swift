//
//  FriendDetailCell.swift
//  Login
//
//  Created by 金成四 on 2024/03/03.
//

import UIKit

class FriendDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    var delegate: SendDataDelegate?
    var textViewType: InputType?
    override func awakeFromNib() {
        super.awakeFromNib()
        messageTextView.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

extension FriendDetailCell: UITextViewDelegate {
    // 监视 textView的编辑结束的状态
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let realUseValueType = textViewType else { return }
        // 执行协议 向外传值
        delegate?.sendData(value: textView.text, valueType: realUseValueType)
    }
}

