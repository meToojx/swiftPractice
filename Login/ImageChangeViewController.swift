//
//  ImageChangeViewController.swift
//  Login
//
//  Created by 金成四 on 2024/02/11.
//

import UIKit

class ImageChangeViewController: UIViewController {
    // MARK: - Outlet
    // 图片
    @IBOutlet private weak var showImageView: UIImageView!
    // 上一个按键
    @IBOutlet private weak var lastButton: UIButton!
    // 下一个按键
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK: - Variable
    private var imageGroup = ["first", "second", "third", "forth"]
    private var originNum = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        showImageView.image = UIImage(named: imageGroup[originNum])

    }
    
    // MARK: - Action
    @IBAction func lastAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        originNum += 1
        if originNum > 3 {
            originNum = 0
        }
        showImageView.image = UIImage(named: imageGroup[originNum])
    }
    
    // MARK: - Function
    private func setUI() {
        // 按键设置
        lastButton.setTitle("上一张", for: .normal)
        nextButton.setTitle("下一张", for: .normal)
        // 图片设置
        showImageView.image = UIImage(named: "second")
//        showImageView.contentMode =
        // 允许图片交互
        showImageView.isUserInteractionEnabled = true
        // 创建点击方法
        let tagGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        // 将点击方法加到图片上
        showImageView.addGestureRecognizer(tagGesture)
    }
    // MARK: - Objc
    @objc func imageTapped() {
        let imageName = imageGroup[originNum]
        let alertView = UIAlertController(title: "被点击了", message: imageName, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(action)
        present(alertView, animated: true)
    }
}
// login 界面 完成 登陆成功 跳转到计算机页面

// 按等号 计算结果为9999的时候 跳出弹窗 弹窗上显示你的计算过程 即 恭喜你 你计算的 num1 +/- num2 = 9999 触发了我们的幸运数字 点击确定 跳转至 图片界面

// 点击图片 跳转至新的页面 显示全屏图片
