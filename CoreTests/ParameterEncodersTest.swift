//
//  File.swift
//  CoreTests
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import XCTest
@testable import Core


class ParameterEncodersTest: XCTestCase {
    func testJSONEncoder() {
        let jsonEncoder = JSONParameterEncoder()
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let parameters = ["first": "firstValue", "second": "secondValue"]
        do {
            try jsonEncoder.encodeParameters(&request, parameters: parameters)
            let data = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            XCTAssertEqual(request.httpBody, data, "Different body")
        } catch {
            XCTFail("Encoding error \(error)")
        }
    }

    func testURLEncoder() {
        let urlEncoder = URLParameterEncoder()
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let parameters = ["first": "firstValue", "second": "secondValue"]
        do {
            try urlEncoder.encodeParameters(&request, parameters: parameters)
            let queryItems: Set<String> = Set(request.url!.query!.split(separator: "&").map{String($0)})
            let predefinedQueryItems: Set<String> = Set(parameters.map({"\($0)=\($1)"}))
            XCTAssertEqual(queryItems, predefinedQueryItems, "Incorrect query")
        } catch {
            XCTFail("Encoding error \(error)")
        }
    }
}

