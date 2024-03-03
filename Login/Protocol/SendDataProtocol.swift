//
//  SendDataProtocol.swift
//  Login
//
//  Created by 金成四 on 2024/03/02.
//

import Foundation

protocol SendDataDelegate {
    func sendData(value: String, valueType: InputType)
    func sendDataBetweenViewController(value: FriendMsg)
}

protocol SendDataInFriend {
    func sendSingleFriendMsg(value: FriendMsg, indexCount: Int)
}
