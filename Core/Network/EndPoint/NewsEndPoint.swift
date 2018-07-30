//
//  NewsEndpoint.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

public enum NewsEndPoint {
    case sources
    case topHeadlines(sourceId: String?, page: UInt)
    case everything(sourceId: String?, page: UInt)
}

extension NewsEndPoint: EndPoint {
    public var path: String {
        switch self {
        case .sources:
            return "sources"
        case .topHeadlines:
            return "top-headlines"
        case .everything:
            return "everything"
        }
    }

    public var htttpMethod: HTTPMethod {
        return .get
    }

    public var parameters: [String : Any]? {
        switch self {
        case .sources:
            return nil
        case let .topHeadlines(sourceId, page):
            guard let sourceId = sourceId else { return nil }
            return [
                "sources": sourceId,
                "page": "\(page)"
            ]
        case let .everything(sourceId, page):
            guard let sourceId = sourceId else { return nil }
            return [
                "sources": sourceId,
                "page": "\(page)"
            ]
        }
    }

    public var encoder: ParameterEncoder {
        return URLParameterEncoder()
    }
}
