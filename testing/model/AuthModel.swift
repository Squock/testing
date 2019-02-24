//
//  AuthModel.swift
//  testing
//
//  Created by squock on 15.02.19.
//  Copyright © 2019 squock. All rights reserved.
//

import Foundation

struct Registration: Codable {
    var firstName: String?
    var lastName: String?
    var secondName: String?
    var phone: String?
    var birthDate: String?
    var cityId: Int?
    var sex: Int?
    let osCode: Int?
    let id: Int?
    let msg: String?
    let success: Int?
    //let code: Int?
    let token: String?
    
    enum CodingKeys: String, CodingKey{
        case firstName = "firstName"
        case lastName = "lastName"
        case secondName = "secondName"
        case phone = "phone"
        case birthDate = "birthDate"
        case cityId = "cityId"
        case sex = "sex"
        case osCode = "osCode"
        case id = "clientId"
        case msg = "msg"
        case success = "success"
        //case code = "code"
        case token = "token"
    }
}
struct getRegistration{
    var cityId: Int?
    var id: Int?
    //let code: Int
    var token: String?
    var phone: String?
    var lastName: String?
    var firstName: String?
    var secondName: String?
    var success: Int?
    var msg: String?
    
    init(cityId: Int?, id: Int?, token: String?, phone: String?, lastName: String?, firstName: String?, secondName: String?, success:Int?, msg: String?){
        self.cityId = cityId
        self.id = id
        self.token = token
        self.phone = phone
        self.lastName = lastName
        self.firstName = firstName
        self.secondName = secondName
        self.success = success
        self.msg = msg
    }
}
