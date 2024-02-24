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
struct MyPageMessage {
    var showMsg: String
    var imageString: String
}


struct Information: Codable {
    var results: [Details]?
}

struct Details: Codable {
    var gender: String?
    var name: Name?
    var location: Address?
    var email: String?
    var phone: String?
    var picture: Head?
}

struct Name: Codable {
    var title: String?
    var first: String?
    var last: String?
}
struct Address: Codable {
    var city: String?
    var state: String?
    var country: String?
}

struct Head: Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

