//
//  Network.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkProtocol {
    func sendRequest(endpoint: EndPoint, completion: @escaping NetworkCompletion)
}

public class Network: NetworkProtocol {
    private enum Consts {
        static let apiKey = "0071f0e02ffc4a0fbf80424888039ead"
    }
    private let baseUrl: URL
    private let urlSession = URLSession(configuration: .default)

    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    public func sendRequest(endpoint: EndPoint, completion: @escaping NetworkCompletion) {
        let dataTask = urlSession.dataTask(with: createRequest(withEndPoint: endpoint), completionHandler: completion)
        dataTask.resume()
    }

    private func createRequest(withEndPoint endPoint: EndPoint) -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.htttpMethod.rawValue
        if let parameters = endPoint.parameters {
            // FIXME: Add error handling
            try? endPoint.encoder.encodeParameters(&request, parameters: parameters)
            guard let url = request.url,
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                    return request
            }
            components.queryItems?.append(URLQueryItem(name: "apiKey", value: Consts.apiKey))
            request.url = components.url
        }
        return request
    }
}
