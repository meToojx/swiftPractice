//
//  CalculatorViewController.swift
//  Login
//
//  Created by 金成四 on 2024/02/10.
//

import UIKit

class CalculatorViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Action
    @IBAction func numberAction(_ sender: UIButton) {
        print(sender.tag)
    }
    // 加法
    @IBAction func addAction(_ sender: UIButton) {
    }
    // 减法
    @IBAction func minuseAction(_ sender: UIButton) {
    }
    // 等于
    @IBAction func equalAction(_ sender: UIButton) {
    }
}
