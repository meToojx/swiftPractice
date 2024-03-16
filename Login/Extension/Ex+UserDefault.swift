//
//  Ex+UserDefault.swift
//  Login
//
//  Created by 金成四 on 2024/03/16.
//

import Foundation
import UIKit

extension UserDefaults {
    // 泛型处理
    // 保存数据
    func setEncode<T: Codable>(key: String, value: T) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(value)
            setValue(data, forKey: key)
        } catch {
            print("保存失败\(error)")
        }
    }
    
    // 取出数据
    func getDecode<T: Codable>(key: String, asType: T.Type) -> T? {
        guard let data = self.data(forKey: key) else { return nil}
        let decoder = JSONDecoder()
        do {
            let value = try decoder.decode(asType, from: data)
            return value
        } catch {
            print("读取失败\(error)")
            return nil
        }
    }
}
