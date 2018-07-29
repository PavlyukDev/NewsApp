//
//  SourcesModel.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import ReactiveSwift
import Core

struct Source: Decodable {
    var id: String
    var name:  String
    var description:  String
    var url: URL
    var category: String
    var language: String
    var country: String
}


struct SourcesResponse: Decodable {
    var status: String
    var sources: [Source]
}

class SourcesModel {
    let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func loadSources() -> SignalProducer<SourcesResponse, NetworkError> {
        return network.sendRequest(endpoint: NewsEndPoint.sources).attemptMap { value in
            guard let data = value.0 else {
                return .failure(.serverError)
            }
            do {
                let response = try JSONDecoder().decode(SourcesResponse.self, from: data)
                return .success(response)
            } catch {
                return .failure(.serverError)
            }
        }
    }
}
