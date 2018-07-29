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
    case topHeadlines
}

extension NewsEndPoint: EndPoint {
    public var path: String {
        switch self {
        case .sources:
            return "sources"
        case .topHeadlines:
            return "top-headlines"
        }
    }

    public var htttpMethod: HTTPMethod {
        return .get
    }

    public var parameters: [String : Any]? {
        switch self {
        case .sources:
            return nil
        case .topHeadlines:
            return [
                "country": "us"
            ]
        }

    }

    public var encoder: ParameterEncoder {
        return URLParameterEncoder()
    }
}
