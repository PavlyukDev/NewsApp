//
//  Network.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import ReactiveSwift

public enum NetworkError: Error {
    case serverError
}

public typealias NetworkCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol NetworkProtocol {
    func sendRequest(endpoint: EndPoint, completion: @escaping NetworkCompletion)
    func sendRequest(endpoint: EndPoint) -> SignalProducer<(Data?, URLResponse?, Error?), NetworkError>
}

public class Network: NetworkProtocol {
    private enum Consts {
        static let apiKey = "d463d36853e04061aabe4c13abbeb16e"
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

    public func sendRequest(endpoint: EndPoint) -> SignalProducer<(Data?, URLResponse?, Error?), NetworkError> {
        return SignalProducer(){ [unowned self] observer, disposable in
            let dataTask = self.urlSession.dataTask(with: self.createRequest(withEndPoint: endpoint)) { data, response, error in
                observer.send(value: (data, response, error))
                observer.sendCompleted()
            }
            dataTask.resume()
        }
    }

    private func createRequest(withEndPoint endPoint: EndPoint) -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.htttpMethod.rawValue
        request.addValue(Consts.apiKey, forHTTPHeaderField: "Authorization")
        if let parameters = endPoint.parameters {
            // FIXME: Add error handling
            try? endPoint.encoder.encodeParameters(&request, parameters: parameters)
        }

        return request
    }
}
