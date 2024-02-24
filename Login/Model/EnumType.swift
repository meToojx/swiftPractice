//
//  EnumType.swift
//  Login
//
//  Created by 金成四 on 2024/02/11.
//

import Foundation


enum AlertType: String {
    case succes = "登陆成功"
    case accountAndPassEmpty = "账号密码不能为空"
    case passWordError = "账号密码不匹配"
    case emailFormError = "邮箱格式不正确"
    case none
}
