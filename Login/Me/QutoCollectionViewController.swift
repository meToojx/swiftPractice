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
        self.view.backgroundColor = UIColor(named: "customBackColor")
        qutoTableview.backgroundColor = UIColor(named: "customBackColor")
        let segWidth = UIScreen.main.bounds.width / 2
        segment.frame = CGRect(x: 0, y: 0, width: segWidth, height: 30)
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< My Page", style: .plain, target: self, action: #selector(backButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "删除", style: .plain, target: self, action: #selector(deleteButtonAction))
        qutoTableview.delegate = self
        qutoTableview.dataSource = self
        qutoTableview.register(UINib(nibName: "SingleQuoteTableViewCell", bundle: nil), forCellReuseIdentifier: "singleQuote")
    }
    func presentAlertView() {
        let alertView = UIAlertController(title: "是否保存数据", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.userdefaults.setEncode(key: "quotes", value: self.showMessage)
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(saveAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true)
    }
    @objc func backButtonAction() {
        print("点击返回按键吧")
        presentAlertView()
    }
    @objc func deleteButtonAction() {
        print("点击删除按键吧")
    }
}

extension QutoCollectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "singleQuote", for: indexPath) as? SingleQuoteTableViewCell else { return UITableViewCell()}
        cell.showMessage = showMessage[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
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

extension QutoCollectionViewController: QutoDelegate {
    func changeData(index: Int) {
        print("已经点击了radio button\(index)")
        self.showMessage[index].isFaviorate.toggle()
        qutoTableview.beginUpdates()
        qutoTableview.endUpdates()
    }
}

// navigationBar右上角 添加选择按键
// 选择按键没有按之前 cell不可被选择
// 选择按钮按了之后 “选择” 变成 “请选择” cell可以进行选择
// 当有第一个cell被选择之后 “请选择” 变成“删除”
// 被选择的cell变成其他颜色 点击删除后 所有变色的cell全部删除 删除按钮变回选择
// 被选择的cell 再被点击 变回原来的颜色
