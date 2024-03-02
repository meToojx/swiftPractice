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


struct Information:Decodable {
    var results:[details]?
}
struct details:Decodable {
    var gender:String?
    var name:Name?
    var location: Adress?
   
    var email:String?
    var phone:String?
    var picture:Head?
}
struct Name :Decodable{
    var title:String?
    var first:String?
}
struct Adress:Decodable {
    var street:DetailAddress?
    var city:String?
    var state:String?
    var country:String?
}
struct DetailAddress:Decodable {
    var number:Int?
    var name:String?
}
struct Head:Decodable {
    var large:String?
}

struct FriendMsg {
    var name: String
    var imageUrlData: Data
    var gender: String
    var address:String
    var phone:String
    var email:String
    var canEdit: Bool = true
}
