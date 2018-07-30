//
//  NewsModel.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import Core

public struct SourceDetail: Decodable {
    public let id: String?
    public let name: String?
}

public struct Article: Decodable {
    public let source: SourceDetail
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: URL?
    public let urlToImage: URL?
    public let publishedAt: String?
}

public struct NewsResponse: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
}


class NewsModel {
    let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }

    func loadNews(with sourceId: String, page: UInt) -> SignalProducer<NewsResponse, NetworkError> {
        return network.sendRequest(endpoint: NewsEndPoint.everything(sourceId: sourceId, page: page)).attemptMap { value in
            guard let data = value.0 else {
                return .failure(.serverError)
            }
            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                return .success(response)
            } catch {
                return .failure(.serverError)
            }
        }
    }
}
