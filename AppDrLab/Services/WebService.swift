//
//  WebService.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    let boundary: String
    var httpMethod: HttpMethod = .get
    var allHTTPHeaderFields: [String:String]? = nil
    var body: Data? = nil
}

extension Resource {
    init(url: URL, boundary: String) {
        self.url = url
        self.boundary = boundary
    }
}

enum NetworkError: Error {
    case domainError
    case decodingError
    case urlError
}

class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.allHTTPHeaderFields = resource.allHTTPHeaderFields
        if resource.body != nil {
            request.setValue("multipart/form-data; boundary=\(resource.boundary)", forHTTPHeaderField: "Content-Type")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
}
