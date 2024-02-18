//
//  Model.swift
//  Login
//
//  Created by 金成四 on 2024/02/11.
//

import Foundation

struct LoginInfo: Codable {
    var mailInfo: String
    var passWordInfo: String
}

struct WechatMessage {
    var name: String
    var imageString: String
    var chatMsg: [String]
    var time: String
}
