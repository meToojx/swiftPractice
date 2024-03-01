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
    var showData: [FriendMsg] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
//    var subShowData: [FriendMsg] = [] {
//        didSet {
//            if subShowData.count >= 10 {
//                self.showData = subShowData
//            }
//        }
//    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI(name: "")
    }
    // MARK: - Function
    func setUI(name: String) {
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        mainTableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        for i in 0...9 {
            viewModel.getData { singleMsg in
                self.showData.append(singleMsg)
            }
        }
        
//        for i in 0...9 {
//            print(1)
//            viewModel.getData { singleMsg in
//                self.subShowData.append(singleMsg)
//            }
//        }
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
}
