//
//  FriendViewModel.swift
//  Login
//
//  Created by 金成四 on 2024/02/24.
//

import Foundation

class FriendViewModel {
    func getData(onComplete: @escaping (FriendMsg) -> Void) {
        let strURL = "https://randomuser.me/api/"
        var session = URLSession(configuration: .default)
        if let url = URL(string: strURL) {
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
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
                    self.setData(getData: realData, onComplete: { singleFriendMsg in
                        onComplete(singleFriendMsg)
                    })
                } catch {
                    print("解析错误\(error)")
                }
                
            })
            task.resume()
        }
    }
    
    private func getPhote(strURL: String, onComplete: @escaping (Data) -> Void) {
        var session: URLSession?
        session = URLSession(configuration: .default)
        // string -> URL
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
                onComplete(useData)
            })
            task?.resume()
        }
    }
    
    private func setData(getData: Information, onComplete: @escaping (FriendMsg) -> Void) {
        // 第一层拆包
        guard let useGetData = getData.results?[0] else { return }
        guard let realname = useGetData.name else { return }
        // 拼接和获取
        let name = (realname.last ?? "" ) + (realname.first ?? "" )
        let gender = useGetData.gender ?? ""
        getPhote(strURL: useGetData.picture?.large ?? "", onComplete: {value in
            var singleMsg = FriendMsg(name: name, imageUrlData: value, gender: gender)
            onComplete(singleMsg)
        })
    }
}
