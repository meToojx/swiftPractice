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
    
    
    // MARK: - Variables
    var showGroup:[String] = ["first", "second", "third", "forth", "fifth","first", "second", "third", "forth", "fifth","first", "second", "third", "forth", "fifth","first", "second", "third", "forth", "fifth"]
    var showGroup2:[String] = ["first", "second", "third", "forth"]
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
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
        if section == 0 {
            return showGroup.count
        } else {
            return showGroup2.count
        }
       
    }
    // row里的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
            cell.textLabel?.text = showGroup[indexPath.row]
            cell.textLabel?.textColor = .blue
            return cell
        } else {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
//            cell.textLabel?.text = showGroup2[indexPath.row]
//            cell.textLabel?.textColor = .yellow
            let image = imageCell.viewWithTag(1) as! UIImageView
            image.image = UIImage(named: showGroup2[indexPath.row])
            image.layer.cornerRadius = 10
            image.layer.masksToBounds = true
            let label = imageCell.viewWithTag(2) as! UILabel
            label.text = showGroup2[indexPath.row]
            label.textColor = .green
            return imageCell
        }
       
    }
    
    // row的点击方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-\(indexPath.section)-------------\(indexPath.row)")
    }
    // row的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "这是第\(section)个section"
    }
}


