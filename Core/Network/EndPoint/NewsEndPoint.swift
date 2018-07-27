//
//  NewsEndpoint.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

public enum NewsEndPoint {
    case topHeadlines
}

extension NewsEndPoint: EndPoint {
    public var path: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        }
    }

    public var htttpMethod: HTTPMethod {
        return .get
    }

    public var parameters: [String : AnyObject]? {
        return [
            "country": "us" as AnyObject
        ]
    }

    public var encoder: ParameterEncoder {
        return URLParameterEncoder()
    }
}
