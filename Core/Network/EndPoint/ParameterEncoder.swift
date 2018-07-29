//
//  ParameterEncoder.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    func encodeParameters(_ request: inout URLRequest, parameters: [String: Any]) throws
}

class JSONParameterEncoder: ParameterEncoder {
    func encodeParameters(_ request: inout URLRequest, parameters: [String: Any]) throws {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = data
    }
}

class URLParameterEncoder: ParameterEncoder {
    func encodeParameters(_ request: inout URLRequest, parameters: [String: Any]) throws {
        guard let url = request.url else { return }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        components.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        request.url = components.url

        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
}
