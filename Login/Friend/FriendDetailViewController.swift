//
//  FriendDetailViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/01.
//

import UIKit

class FriendDetailViewController: UIViewController {
    // MARK: - Outlets
    // 当前的tableview
    @IBOutlet weak var secondTableView: UITableView!
    // 显示的头像
    @IBOutlet weak var twoheadImageView: UIImageView!
    // MARK: - Variables
    // 主要显示信息
    var onemessage:FriendMsg?
    var delegate: SendDataDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // tablevie的相关设定
        secondTableView.dataSource = self
        secondTableView.delegate = self
        // 图片显示 data类型
        twoheadImageView.image = UIImage(data: onemessage!.imageUrlData)
    }

    // MARK: - Action
    // navigationbar 右上方保存按键
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        if let realOneMessage = onemessage {
            delegate?.sendDataBetweenViewController(value: realOneMessage)
        }
        self.navigationController?.popViewController(animated: true)
    }
    // 点击空白处使键盘消失
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
// MARK: - UITableViewDataSource,UITableViewDelegate
extension FriendDetailViewController: UITableViewDataSource,UITableViewDelegate {
    // row的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    // row的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 实例化我们建好的cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendDetailCell", for: indexPath) as? FriendDetailCell else { return UITableViewCell()}
        cell.delegate = self
        cell.messageTextView.isEditable = onemessage?.canEdit ?? true
        switch indexPath.row {
        case 0:
            // 第一个row显示姓名
            cell.titleLabel.text = "name"
            cell.messageTextView.text = onemessage?.name
        case 1:
            // 第二个row显示性别
            cell.titleLabel.text = "gender"
            cell.messageTextView.text = onemessage?.gender
        case 2:
            // 第三个row显示电话
            cell.titleLabel.text = "phone"
            cell.messageTextView.text = onemessage?.phone
        case 3:
            // 第四个row显示邮箱
            cell.titleLabel.text = "email"
            cell.messageTextView.text = onemessage?.email
        default:
            // 最后一个row显示地址
            cell.titleLabel.text = "address"
            cell.messageTextView.text = onemessage?.address
        }
        return cell
    }
    // row的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 4 ? 150 : 100
    }
    // 点击row的方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

extension FriendDetailViewController: SendDataDelegate {
    func sendDataBetweenViewController(value: FriendMsg) {
    }
    
    func sendData(value: String/*, intputType: xxxxenum*/ ) {
//        switch intputType {
//        case .name:
//            onemessage?.name = value
//        case .address:
//            onemessage?.address = value
//        case .gender:
//            
//        }
        onemessage?.name = value
    }
}



class FriendDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    var delegate: SendDataDelegate?
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
        delegate?.sendData(value: textView.text)
    }
}
