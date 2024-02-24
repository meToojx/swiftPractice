//
//  MainChatViewModel.swift
//  Login
//
//  Created by 金成四 on 2024/02/24.
//

import Foundation
import UIKit

class MainChatViewModel: NSObject {
    var mainMessage = [
        WechatMessage(name: "Alice", imageString: "first", chatMsg: ["Hey, how's your day going?"], time: "09:30 AM"),
        WechatMessage(name: "Bob", imageString: "second", chatMsg: ["Just landed in New York. It's amazing here!"], time: "10:45 AM"),
        WechatMessage(name: "Charlie", imageString: "third", chatMsg: ["Can you send me the report by EOD?"], time: "11:00 AM"),
        WechatMessage(name: "Diana", imageString: "forth", chatMsg: ["Don't forget our meeting tomorrow at 10."], time: "01:15 PM"),
        WechatMessage(name: "Evan", imageString: "fifth", chatMsg: ["Lunch today? My treat!"], time: "11:30 AM"),
        WechatMessage(name: "Fiona", imageString: "sixth", chatMsg: ["Great job on the presentation!"], time: "02:50 PM")
    ]
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
//                DispatchQueue.main.async {
//                    let useImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//                    useImage.image = loadImage
//                    self.view.addSubview(useImage)
//                }
            })
            task?.resume()
        }
    }
    
    func setData(getData: Information) {
        guard let useGetData = getData.results?[0] else { return }
        // 返回主线程 更新UI
//        DispatchQueue.main.async {
//            self.displayLabel.text = useGetData.name?.first
//        }
        getPhote(strURL: useGetData.picture?.large ?? "")
    }
}

