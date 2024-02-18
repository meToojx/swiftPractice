//
//  LoginViewController.swift
//  Login
//
//  Created by 金成四 on 2024/02/10.
//




// viewDidLoad 保存一个数据 数据类型是你自己定的。 保存之后 再读取 读取成功之后 print出数据

import UIKit

class LoginViewController: UIViewController {

    // MARK: - OutLet
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    // Userdefaults
    let userDefaults = UserDefaults.standard
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setViewDelegate()
    }
    
    // MARK: - Action
    
    @IBAction func loginAction(_ sender: UIButton) {
        let currentType = checkLoginMessage()
        showAlertView(alertType: currentType)
        userDefaults.set(mailTextField.text, forKey: "mail")
        userDefaults.set(passwordTextFiled.text, forKey: "passWord")
        let loginInfoMessage = LoginInfo(mailInfo: mailTextField.text ?? "", passWordInfo: passwordTextFiled.text ?? "")
//        userDefaults.removeObject(forKey: <#T##String#>)
        do {
            // 自定义类型 -》 data类型
            let encodeata = try JSONEncoder().encode(loginInfoMessage)
            // 存储
            userDefaults.setValue(encodeata, forKey: "loginInfo")
        } catch {
            print("failed to encode loginInfoMessage \(error.localizedDescription)")
        }
    }
    
    // MARK: - Function
    // 画面デザイン
    func setUI() {
        // 背景颜色
        self.view.backgroundColor = .black
        // mail設定
        mailLabel.text = "邮箱"
        mailLabel.textColor = .red
        // passWord设定
        passwordLabel.text = "密码"
        passwordLabel.textColor = .red
        // button设定
        loginButton.setTitle("登陆", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        // textField设定
        mailTextField.tag = 1
        mailTextField.keyboardType = .emailAddress
        passwordTextFiled.tag = 2
        passwordTextFiled.keyboardType = .numberPad
        passwordTextFiled.isSecureTextEntry = true
//        let savedMail = userDefaults.string(forKey: "mail")
//        let savedPassword = userDefaults.string(forKey: "passWord")
        // 取出数据
        let loginInfoData = userDefaults.data(forKey: "loginInfo")
        // data？ -> data
        guard let useLoginInfoData = loginInfoData else { return  }
        do {
            let decodeDate = try JSONDecoder().decode(LoginInfo.self, from: useLoginInfoData)
            mailTextField.text = decodeDate.mailInfo
            passwordTextFiled.text = decodeDate.passWordInfo
        } catch {
            print("failed to decode \(error.localizedDescription)")
        }
       
    }
    func setViewDelegate() {
        mailTextField.delegate = self
        passwordTextFiled.delegate = self
    }
    func checkLoginMessage() -> AlertType {
        // 获得邮箱信息 如果为nill 返回的错误类型为 accountAndPassEmpty
        guard let mailText = mailTextField.text else { return .accountAndPassEmpty}
        // 获得密码信息 如果为nill 返回的错误类型为 accountAndPassEmpty
        guard let passText = passwordTextFiled.text else { return .accountAndPassEmpty}
        // 如果邮件信息为“” 或者密码信息为“” 则返回accountAndPassEmpty
        if mailText.isEmpty || passText.isEmpty { return .accountAndPassEmpty }
        // 判断输入的密码和账户是否正确
        let isRight = rightAccountAndPassWord(accountMsg: mailText, passWord: passText)
        // 如果输入的账户和密码不匹配 则返回passWordError
        if !isRight { return .passWordError}
        // 如果没有以上的错误 则返回成功
        return .succes
    }
    // 账户和密码是否匹配的方法
    func rightAccountAndPassWord(accountMsg: String, passWord: String) -> Bool {
        return accountMsg == "swift@gmail.com" && passWord == "0987654321"
    }
    
    func showAlertView(alertType: AlertType) {
        let titleMessage = alertType == .succes ? "成功" : "失败"
        let alertController = UIAlertController(title: titleMessage, message: alertType.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
            if alertType == .passWordError {
                self.mailTextField.text?.removeAll()
                self.passwordTextFiled.text?.removeAll()
            }
            if alertType == .succes {
                // Login是 storyboard的文件名
                let storyBoard = UIStoryboard(name: "Login", bundle: nil)
                // canScroll是 UIviewController的ID名
                let viewController = storyBoard.instantiateViewController(identifier: "canScroll") as! CanScrollViewController
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        })
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 已经显示的文字
        let currentText = textField.text ?? ""
        // 替换范围
        guard let stringRange = Range(range, in: currentText) else { return false}
        // 将要显示的完整字符串
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        switch textField.tag {
        case 1:
            print("这是输入邮箱的输入框")
        case 2:
            print("这是输入密码的输入框")
            // 密码框的输入限制
            if updateText.count > 12 {
                return false
            }
        default:
            break
        }
        return true
    }
}
