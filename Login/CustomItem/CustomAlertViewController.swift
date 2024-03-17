//
//  CustomAlertViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/17.
//

import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var catgoryLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var changSwitch: UISwitch!
    
    // MARK: - Variables
    var quotesMessage: UseQuote?
    var userDefaults = UserDefaults.standard
    init() {
        super.init(nibName: "CustomAlertViewController", bundle: Bundle(for: CustomAlertViewController.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Action
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func saveAcvtion(_ sender: UIButton) {
        guard let useMessage = quotesMessage else { return }
        saveData(newQuote: useMessage)
        self.dismiss(animated: true)
    }
    
    @IBAction func isFavoriteSwitch(_ sender: UISwitch) {
        quotesMessage?.isFaviorate = sender.isOn
    }
    
    
    func setUI() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        guard let useMessage = quotesMessage else { return }
        authorLabel.text = useMessage.quoteMsg.author
        catgoryLabel.text = useMessage.quoteMsg.category
        quoteLabel.text = useMessage.quoteMsg.quote
        changSwitch.isOn = useMessage.isFaviorate
    }
    func showAler() {
//        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true)
        let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
        windowScene?.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
    }
    func saveData(newQuote: UseQuote) {
        // 新建数组 用来放旧的数组
        let saveKey = "quotes"
        var extistedGroup: [UseQuote] = []
        guard let realData = userDefaults.getDecode(key: saveKey, asType: [UseQuote].self) else {
            // 如果之前没保存过数据
            // 放入userDefaults
            extistedGroup.append(newQuote)
            userDefaults.setEncode(key: saveKey, value: extistedGroup)
            return
        }
        // 如果之前保存过数据 则取出旧数据
        extistedGroup = realData
        print("已经存在了\(extistedGroup.count)条数据")
        extistedGroup.append(newQuote)
        // 放入userDefaults
        userDefaults.setEncode(key: saveKey, value: extistedGroup)
    }
}
