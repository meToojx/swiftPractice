//
//  FriendViewController.swift
//  Login
//
//  Created by 金成四 on 2024/02/24.
//

import UIKit

class FriendViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var mainTableView: UITableView!
    // MARK: - Variable
    var viewModel = FriendViewModel()
    // 画面主要显示的数据
    var showData: [FriendMsg] = [] {
        didSet {
            DispatchQueue.main.async {
                // 每当数据被更新的时候 就刷线tableView 更新视图
                self.mainTableView.reloadData()
            }
        }
    }
    // 新建加载视图
    let indicatorView = UIActivityIndicatorView()
    var selectRow = 0
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    // MARK: - Action
    // navigationbar的右侧按键
    @IBAction func friendUpData(_ sender: UIBarButtonItem) {
        getAndUpdateData()
    }
    // MARK: - Function
    func setUI() {
        // tableView的相关设定
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        // navigationBar 的相关设定
        navigationItem.title = "Friend"
        // 加载视图的相关设定
        indicatorView.style = .large
        indicatorView.color = .blue
        indicatorView.center = self.view.center
        indicatorView.hidesWhenStopped = true
        // 将加载视图添加到当前桌面
        self.view.addSubview(indicatorView)
        getAndUpdateData()
    }
    func getAndUpdateData() {
        // 加载启动
        indicatorView.startAnimating()
        // 通信过程中使点击无效化
        self.view.isUserInteractionEnabled = false
        // 清空当前页面
        self.viewModel.friends.removeAll()
        // 执行10次通信 （串联）
        viewModel.getData(count: 9) {
            // 通信结束以后 将所得数据放到当前视图的数据中
            self.showData = self.viewModel.friends
            // 加载停止
            self.indicatorView.stopAnimating()
            // 通信结束 点击有效
            self.view.isUserInteractionEnabled = true
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
        cell.mainMsg = showData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow = indexPath.row
        // 设定storyBoard
        let storyBoard: UIStoryboard = UIStoryboard(name: "FriendDetailViewController", bundle: nil)
        // 实例化一个viewcontroller
        let viewController = storyBoard.instantiateViewController(identifier: "friendDetail") as! FriendDetailViewController
        // 隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = true
        viewController.onemessage = showData[indexPath.row]
        viewController.delegate = self
        // push跳转
        navigationController?.pushViewController(viewController, animated: true)
    }
}
extension FriendViewController: SendDataDelegate {
    func sendData(value: String) {
        
    }
    
    func sendDataBetweenViewController(value: FriendMsg) {
        showData[selectRow] = value
    }
}
