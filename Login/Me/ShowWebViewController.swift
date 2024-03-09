//
//  ShowWebViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/09.
//

import UIKit
import WebKit
class ShowWebViewController: UIViewController {

    @IBOutlet weak var mainWebview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI() {
        // ブジェクトを生成
        let myURL = URL(string:"https://www.apple.com")
        // オブジェクトを生成
        let myRequest = URLRequest(url: myURL!)
        // WebView にロード
        mainWebview.load(myRequest)
    }
}
