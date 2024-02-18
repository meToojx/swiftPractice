//
//  CanScrollViewController.swift
//  Login
//
//  Created by 金成四 on 2024/02/14.
//

import UIKit

class CanScrollViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var settingImageView: UIImageView!
    
    // MARK: - Variables
    let messages = [
        WechatMessage(name: "Alice", imageString: "first", chatMsg: ["Hey, how's your day going?"], time: "09:30 AM"),
        WechatMessage(name: "Bob", imageString: "second", chatMsg: ["Just landed in New York. It's amazing here!"], time: "10:45 AM"),
        WechatMessage(name: "Charlie", imageString: "third", chatMsg: ["Can you send me the report by EOD?"], time: "11:00 AM"),
        WechatMessage(name: "Diana", imageString: "forth", chatMsg: ["Don't forget our meeting tomorrow at 10."], time: "01:15 PM"),
        WechatMessage(name: "Evan", imageString: "fifth", chatMsg: ["Lunch today? My treat!"], time: "11:30 AM"),
        WechatMessage(name: "Fiona", imageString: "sixth", chatMsg: ["Great job on the presentation!"], time: "02:50 PM")
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       setUI()
    }
    // MARK: - objc
    @objc func imageTapAction() {
        // 制作弹窗
        let alertView = UIAlertController(title: "确定要退出吗", message: "推出后数据将消失", preferredStyle: .actionSheet)
        // 确定按键
        let alertAction = UIAlertAction(title: "确定", style: .destructive) { _ in
            // 确定之后执行的方法
            self.navigationController?.popViewController(animated: false)
        }
        // 取消按键
        let alertAction2 = UIAlertAction(title: "取消", style: .default)
        // 将按键添加到弹窗
        alertView.addAction(alertAction)
        alertView.addAction(alertAction2)
        // 弹出视图
        self.present(alertView, animated: true)
    }
    // MARK: - Function
    func setUI() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "ConnectTableViewCell", bundle: nil), forCellReuseIdentifier: "connectCell")
        // 隐藏返回按键
        self.navigationItem.hidesBackButton = true
        // 设置标题
        self.navigationItem.title = "WeChat"
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightButton
        
        //
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(imageTapAction))
        settingImageView.backgroundColor = .systemBlue
        settingImageView.tintColor = .white
        settingImageView.layer.cornerRadius = 25
        settingImageView.layer.masksToBounds = true
        settingImageView.isUserInteractionEnabled = true
        settingImageView.addGestureRecognizer(tapAction)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension CanScrollViewController: UITableViewDelegate, UITableViewDataSource {
    // section的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // row的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : messages.count
    }
    // row里的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! MainChatListTableViewCell
            // 通过tag寻找cell内的控件 强制转换以后使用
    //        let image = imageCell.viewWithTag(1) as! UIImageView
    //        image.image = UIImage(named: messages[indexPath.row].imageString)
    //        image.layer.cornerRadius = 10
    //        image.layer.masksToBounds = true
    //        let namelabel = imageCell.viewWithTag(2) as! UILabel
    //        namelabel.text = messages[indexPath.row].name
    //        let timelabel = imageCell.viewWithTag(3) as! UILabel
    //        timelabel.text = messages[indexPath.row].time
    //        let msglabel = imageCell.viewWithTag(4) as! UILabel
    //        msglabel.text = messages[indexPath.row].chatMsg.last
            
            // 是单独建立一个类以后 把cell内的控件 一个一个设置更新
    //        imageCell.mainImage.image = UIImage(named: messages[indexPath.row].imageString)
    //        imageCell.nameLabel.text = messages[indexPath.row].name
    //        imageCell.timeLabel.text = messages[indexPath.row].time
    //        imageCell.msgLabel.text = messages[indexPath.row].chatMsg.last
            
            // 把数据传送给cell以后 让cell自己更新
            imageCell.useData = messages[indexPath.row]
            return imageCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "connectCell", for: indexPath) as! ConnectTableViewCell
            cell.setUI()
            return cell
        }

    }
    
    // row的点击方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-\(indexPath.section)-------------\(indexPath.row)")
    }
    // row的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return indexPath.section == 1 ? 82 : 180
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "这是第\(section)个section"
//    }
}

