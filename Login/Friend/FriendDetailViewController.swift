//
//  FriendDetailViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/01.
//

import UIKit

class FriendDetailViewController: UIViewController {
    
    @IBOutlet weak var secondTableView: UITableView!
    @IBOutlet weak var twoheadImageView: UIImageView!
    var onemessage:FriendMsg?
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTableView.dataSource = self
        secondTableView.delegate = self
        twoheadImageView.image = UIImage(data: onemessage!.imageUrlData)
        secondTableView.tableFooterView = UIView()
        
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension FriendDetailViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendDetailCell", for: indexPath) as? FriendDetailCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "name"
            cell.messageTextView.text = onemessage?.name
        case 1:
            cell.titleLabel.text = "gender"
            cell.messageTextView.text = onemessage?.gender
        case 2:
            cell.titleLabel.text = "phone"
            cell.messageTextView.text = onemessage?.phone
        case 3:
            cell.titleLabel.text = "email"
            cell.messageTextView.text = onemessage?.email
        default:
            cell.titleLabel.text = "address"
            cell.messageTextView.text = onemessage?.address
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 4 ? 150 : 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

class FriendDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
//    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        messageLabel.numberOfLines = 0
        self.selectionStyle = .none
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
