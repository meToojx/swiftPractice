//
//  QutoCollectionViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/17.
//

import UIKit

class QutoCollectionViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var changeSegmentController: UISegmentedControl!
    @IBOutlet weak var qutoTableview: UITableView!
    // MARK: - Variable
    var showMessage: [UseQuote] = []
    var userdefaults = UserDefaults.standard
    let segment: UISegmentedControl = UISegmentedControl(items: ["All", "Like"])
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let quotes = userdefaults.getDecode(key: "quotes", asType: [UseQuote].self)
        if let realQuotes = quotes {
            showMessage = realQuotes
        }
        setUI()
    }
    // MARK: - Action
    // 点击segement时候的方法
    @IBAction func changeSegmentAction(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
//        qutoTableview.reloadData()
        qutoTableview.beginUpdates()
        qutoTableview.endUpdates()
    }
    
    
    // MARK: - Function
    func setUI() {
        let segWidth = UIScreen.main.bounds.width / 2
        segment.frame = CGRect(x: 0, y: 0, width: segWidth, height: 30)
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< My Page", style: .plain, target: self, action: #selector(backButtonAction))
        qutoTableview.delegate = self
        qutoTableview.dataSource = self
        qutoTableview.register(UINib(nibName: "SingleQuoteTableViewCell", bundle: nil), forCellReuseIdentifier: "singleQuote")
    }
    @objc func backButtonAction() {
        print("点击返回按键吧")
        navigationController?.popViewController(animated: true)
    }
}

extension QutoCollectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "singleQuote", for: indexPath) as? SingleQuoteTableViewCell else { return UITableViewCell()}
        cell.showMessage = showMessage[indexPath.row]
        return cell
    }
    // 编辑侧滑功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 侧滑删除
        if editingStyle == .delete {
            // 数据删除
            showMessage.remove(at: indexPath.row)
            // 指定的row删除
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if changeSegmentController.selectedSegmentIndex == 1 {
            return showMessage[indexPath.row].isFaviorate ? UITableView.automaticDimension : 0
        } else {
            return UITableView.automaticDimension
        }
    }
}
