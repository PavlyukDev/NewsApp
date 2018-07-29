//
//  EndPoint.swift
//  Core
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

public protocol EndPoint {
    var path: String { get }
    var htttpMethod: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var encoder: ParameterEncoder { get }
}
