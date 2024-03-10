//
//  MyViewController.swift
//  Login
//
//  Created by 金成四 on 2024/02/18.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    let service = [
        MyPageMessage(showMsg: "服务", imageString: "service")
    ]
    let myPageMesg = [
    MyPageMessage(showMsg: "朋友圈", imageString: "friend"),
    MyPageMessage(showMsg: "视频", imageString: "video"),
    MyPageMessage(showMsg: "卡包", imageString: "card"),
    MyPageMessage(showMsg: "表情", imageString: "emoji"),
    MyPageMessage(showMsg: "收藏", imageString: "collection")
    ]
    let settingMsg = [
        MyPageMessage(showMsg: "设置", imageString: "setting")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .systemGray6
        mainTableView.register(UINib(nibName: "MeTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        mainTableView.register(UINib(nibName: "ConnectTableViewCell", bundle: nil), forCellReuseIdentifier: "connectCell")
        navigationItem.title = "My Page"
    }
    // MARK: - Function
    func presentAction() {
        let alertController = UIAlertController(title: "失败", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}

extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return service.count
        case 2:
            return myPageMesg.count
        case 3:
            return settingMsg.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "connectCell", for: indexPath) as! ConnectTableViewCell
            cell.setUI()
            // 传递函数
            cell.statusAction = presentAction
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MeTableViewCell
            cell.showData = service[indexPath.row]
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MeTableViewCell
            cell.showData = myPageMesg[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MeTableViewCell
            cell.showData = settingMsg[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 160 : 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let storyBoard = UIStoryboard(name: "Service", bundle: nil)
                let viewController = storyBoard.instantiateViewController(identifier: "Service") as! ServiceViewController
                viewController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(viewController, animated: true)
            default:
                break
            }
        } else {
            Netmanager().commonNet(category: .anger)
        }
        
    }
    // 设置footerView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // 自定义一个UIView 设置高为1 宽为 tableview的宽
        let view = UIView(frame: CGRect(x: 0, y: 0, width: mainTableView.frame.width, height: 1))
        // 改变自定义view的背景颜色
        view.backgroundColor = .systemGray6
        // 返回并利用该view
        return view
    }
    // 设置footerView的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
}
