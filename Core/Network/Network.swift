//
//  Network.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import ReactiveSwift

public struct Source: Decodable {
    let id: String
    let name: String?
}

public struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
}

public struct Response: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

public enum NetworkError: Error {

}

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

    public func sendRequest(endpoint: EndPoint) -> SignalProducer<(Data?, URLResponse?, Error?), NetworkError> {
        return SignalProducer(){ [unowned self] observer, disposable in
            let dataTask = self.urlSession.dataTask(with: self.createRequest(withEndPoint: endpoint)) { data, response, error in
                observer.send(value: (data, response, error))
            }
            dataTask.resume()
        }
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
