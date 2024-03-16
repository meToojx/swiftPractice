//
//  CardBagViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/13.
//

import UIKit

class CardBagViewController: UIViewController {
    
    @IBOutlet weak var showTextField: UITextField!
    @IBOutlet weak var getButton: UIButton!
    
    let showPickerVIew: UIPickerView = UIPickerView()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    @IBAction func getAction(_ sender: UIButton) {
        // 收回键盘
        self.view.endEditing(true)
        // 显示加载
        self.showIndicatorView()
        // 获得种类
        let textInTextField = showTextField.text ?? ""
        // 得到对应case
        let quoteCase = QuoteCategory(rawValue: textInTextField)
        // 拆包 case？ -> case
        guard let realQuoteCase = quoteCase else {
            // 停止显示加载动画
            self.stopShowIndicatorView()
            return
        }
        // 通信获取数据
        Netmanager().commonNet(category: realQuoteCase, onComplete: {value in
            // 回到主线程
            DispatchQueue.main.async {
                // 停止显示加载动画
                self.stopShowIndicatorView()
                // 弹出弹窗
                self.presentAction(showMsg: value)
            }
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func setUI() {
        // button
        getButton.backgroundColor = .blue
        getButton.tintColor = .green
        getButton.layer.cornerRadius = 10
        getButton.layer.masksToBounds = true
        getButton.setTitle("Get Words", for: .normal)
        // pickerView
        showPickerVIew.delegate = self
        showPickerVIew.dataSource = self
        // textField
        showTextField.inputView = showPickerVIew
        
    }
    func presentAction(showMsg: Quote) {
        let alertController = UIAlertController(title: showMsg.quote, message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            // 保存数据
            self.saveData(newQuote: showMsg)
        }
        let cancelAaction = UIAlertAction(title: "cancel", style: .cancel)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAaction)
        present(alertController, animated: true)
    }
    
    func saveData(newQuote: Quote) {
        // 新建数组 用来放旧的数组
        let saveKey = "quotes"
        var extistedGroup: [UseQuote] = []
        guard let realData = userDefaults.getDecode(key: saveKey, asType: [UseQuote].self) else {
            // 如果之前没保存过数据
            // 放入userDefaults
            extistedGroup.append(UseQuote(quoteMsg: newQuote))
            userDefaults.setEncode(key: saveKey, value: extistedGroup)
            return
        }
        // 如果之前保存过数据 则取出旧数据
        extistedGroup = realData
        print("已经存在了\(extistedGroup.count)条数据")
        extistedGroup.append(UseQuote(quoteMsg: newQuote))
        // 放入userDefaults
        userDefaults.setEncode(key: saveKey, value: extistedGroup)
    }
}

extension CardBagViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 获得当前枚举类型里的全部case数量
        return QuoteCategory.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 显示对应内容
        return QuoteCategory.allCases[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 选择以后显示在textfield里
        showTextField.text = QuoteCategory.allCases[row].rawValue
    }
}
