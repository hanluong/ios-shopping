//
//  Common.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isPasswordValid(_ password : String) -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}

func generateBoundary() -> String {
    return "Boundary-\(UUID().uuidString)"
}

func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
    
    let lineBreak = "\r\n"
    var body = Data()
    
    if let parameters = params {
        for (key, value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value + lineBreak)")
        }
    }
    
    if let media = media {
        for photo in media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
    }
    
    body.append("--\(boundary)--\(lineBreak)")
    
    return body
}
