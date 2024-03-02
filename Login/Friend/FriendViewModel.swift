//
//  FriendViewModel.swift
//  Login
//
//  Created by 金成四 on 2024/02/24.
//

import Foundation

class FriendViewModel {
    // 用来接收通信得到的数据
    var friends: [FriendMsg] = []
    func getData(count:Int, onComplete: @escaping () -> Void) {
        let strURL = "https://randomuser.me/api/"
        let session = URLSession(configuration: .default)
        let useCount = count - 1 // 计数用flag
        if let url = URL(string: strURL) {
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                // 判断通信错误
                // 有的话返回
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                // data拆包
                guard let useData = data else { return }
                do {
                    // 将data类型转换成自建模型
                    let realData = try JSONDecoder().decode(Information.self, from: useData)
                    // 处理数据
                    self.setData(getData: realData, onComplete: { singleFriendMsg in
                        // 添加处理完成的数据
                        self.friends.append(singleFriendMsg)
                        if useCount >= 0{
                            // 通信结束以后，并且在数据处理完成之后 如果满足条件 则 递归
                            self.getData(count: useCount, onComplete: onComplete)
                        } else {
                            DispatchQueue.main.async {
                                onComplete()
                            }
                        }
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
        if let rootInfo = getData.results?[0]{
            let title = rootInfo.name?.title
            let first = rootInfo.name?.first
            let fullname:String = {
                guard let realtitle = title, let realfirst = first else {
                    return ""
                }
                return "\(realtitle) \(realfirst)"
            }()
            let gender = rootInfo.gender ?? ""
            let email = rootInfo.email ?? ""
            let phoneNumber = rootInfo.phone ?? ""
            let address1 = rootInfo.location?.street?.number
            let address2 = rootInfo.location?.city
            let address3 = rootInfo.location?.country
            let address4 = rootInfo.location?.state
            let address5 = rootInfo.location?.street?.name
            let fullAdress: String = {
                guard let real1 = address1, let real2 = address2, let real3 = address3 ,let real4 = address4,
                      let real5 = address5 else
                {
                    return ""
                }
                return "\(real1)\n \(real2) \n \(real3)\n \(real4)\n \(real5)"
                
            }()
            getPhote(strURL: rootInfo.picture?.large ?? "", onComplete: {value in
                let singleMsg = FriendMsg(name: fullname, imageUrlData: value, gender: gender, address: fullAdress, phone: phoneNumber, email: email)
                onComplete(singleMsg)
            })
        }
    }
}
