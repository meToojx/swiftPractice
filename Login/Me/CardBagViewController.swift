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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    @IBAction func getAction(_ sender: UIButton) {
        let textInTextField = showTextField.text ?? ""
        let quoteCase = QuoteCategory(rawValue: textInTextField)
        guard let realQuoteCase = quoteCase else { return }
        Netmanager().commonNet(category: realQuoteCase, onComplete: {value in
            DispatchQueue.main.async {
                self.presentAction(showMsg:  value.quote)
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
    func presentAction(showMsg: String) {
        let alertController = UIAlertController(title: showMsg, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            print("点击了Ok按键")
        }
        let baction = UIAlertAction(title: "off", style: .cancel)
        let caction = UIAlertAction(title: "third", style: .destructive)
        alertController.addAction(action)
        alertController.addAction(baction)
        alertController.addAction(caction)
        present(alertController, animated: true)
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
