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
        getData()
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
    
    
    
    
    func getData() {
        let strURL = "https://randomuser.me/api/"
        var session: URLSession?
        session = URLSession(configuration: .default)
        if let url = URL(string: strURL) {
            let task = session?.dataTask(with: url, completionHandler: {(data, response, error) in
                // 判断通信错误
                if error != nil {
                    // 有的话返回
                    print(error!.localizedDescription)
                    return
                }
                // data拆包
                guard let useData = data else { return }
                do {
                    // 将data类型转换成自建模型
                    let realData = try JSONDecoder().decode(Information.self, from: useData)
                    self.setData(getData: realData)
                } catch {
                    print(error.localizedDescription)
                }
                
            })
            task?.resume()
        }
    }
    
    func getPhote(strURL: String) {
        var session: URLSession?
        session = URLSession(configuration: .default)
        if let url = URL(string: strURL) {
            let task = session?.dataTask(with: url, completionHandler: {(data, response, error) in
                // 判断通信错误
                if error != nil {
                    // 有的话返回
                    print(error!.localizedDescription)
                    return
                }
                // data拆包
                guard let useData = data else { return }
                let loadImage = UIImage(data: useData)
                DispatchQueue.main.async {
                    let useImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                    useImage.image = loadImage
                    self.view.addSubview(useImage)
                }
            })
            task?.resume()
        }
    }
    
    
    
    func setData(getData: Information) {
        guard let useGetData = getData.results?[0] else { return }
        // 返回主线程 更新UI
        DispatchQueue.main.async {
            self.displayLabel.text = useGetData.name?.first
        }
        getPhote(strURL: useGetData.picture?.large ?? "")
    }
}
