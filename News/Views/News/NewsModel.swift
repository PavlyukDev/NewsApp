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

class NewsModel {
    let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }

    func loadNews(with sourceId: String) -> SignalProducer<Response, NetworkError> {
        return network.sendRequest(endpoint: NewsEndPoint.topHeadlines(sourceId: sourceId)).attemptMap { value in
            guard let data = value.0 else {
                return .failure(.serverError)
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return .success(response)
            } catch {
                return .failure(.serverError)
            }
        }
    }
}
