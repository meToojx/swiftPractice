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
//    @IBOutlet private weak var showImageView: UIImageView!
    // 上一个按键
    @IBOutlet private weak var lastButton: UIButton!
    // 下一个按键
    @IBOutlet private weak var nextButton: UIButton!
    // collectionView
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    // MARK: - Variable
    private var imageGroup = ["first", "second", "third", "forth"]
    private var originNum = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        showImageView.image = UIImage(named: imageGroup[originNum])

    }
    
    // MARK: - Action
    @IBAction func lastAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        originNum += 1
        if originNum > 3 {
            originNum = 0
        }
//        showImageView.image = UIImage(named: imageGroup[originNum])
    }
    
    // MARK: - Function
    private func setUI() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.showsHorizontalScrollIndicator = false
        imageCollectionView.showsVerticalScrollIndicator = false
//        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        // 按键设置
        lastButton.setTitle("上一张", for: .normal)
        nextButton.setTitle("下一张", for: .normal)
        // 图片设置
//        showImageView.image = UIImage(named: "second")
////        showImageView.contentMode =
//        // 允许图片交互
//        showImageView.isUserInteractionEnabled = true
//        // 创建点击方法
//        let tagGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        // 将点击方法加到图片上
//        showImageView.addGestureRecognizer(tagGesture)
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

extension ImageChangeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // cell数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageGroup.count
    }
    // cell内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.showLabel.text = imageGroup[indexPath.row]
        cell.showImage.image = UIImage(named: imageGroup[indexPath.row])
        cell.setUI()
        return cell
    }
    // cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 获取当前页面collectionview的宽度
        let width = self.imageCollectionView.frame.width
        // 获取当前页面collectionview的高度
        let height = self.imageCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
    //间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

