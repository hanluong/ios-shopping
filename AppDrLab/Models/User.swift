//
//  User.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String?
    var id: String?
    let email: String
    var password: String?
    var token: String?
    var os: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "member_name"
        case id = "member_idx"
        case email = "member_id"
        case password = "member_pw"
        case token = "gcm_key"
        case os = "device_os"
    }
}

extension User {
    init?(_ vm: LoginViewModel) {
        guard let email = vm.email,
            let password = vm.password,
            let token = vm.token,
            let os = vm.os else { return nil }
        self.email = email
        self.password = password
        self.token = token
        self.os = os
    }
}

extension User {
    
    static func login(vm: LoginViewModel) -> Resource<User?> {
        guard let url = URL(string: "http://dev-api.martjangbogo.com/login_v_1_0_0/member_login") else { fatalError() }
        let user = User(vm)
        guard let parameters = try? user?.asDictionary() else { fatalError() }
        let boundary = generateBoundary()
        let dataBody = createDataBody(withParameters: parameters, media: nil, boundary: boundary)
        var resource = Resource<User?>(url: url, boundary: boundary)
        resource.httpMethod = .post
        resource.body = dataBody
        
        return resource
    }
}


