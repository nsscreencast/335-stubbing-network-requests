//
//  FixtureLoader.swift
//  CoinListTests
//
//  Created by Ben Scheirman on 2/23/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import Foundation
import OHHTTPStubs

class FixtureLoader {
    static func reset() {
        OHHTTPStubs.removeAllStubs()
    }
    
    static func stubCoinListResponse() {
        stub(condition:
        isHost("min-api.cryptocompare.com") && isPath("/data/all/coinlist")) { req -> OHHTTPStubsResponse in
            return jsonFixture(with: "coinlist.json")
        }
    }
    
    static func stubCoinListReturningError() {
        stub(condition:
        isHost("min-api.cryptocompare.com") && isPath("/data/all/coinlist")) { req -> OHHTTPStubsResponse in
            
            let data = "Server Error".data(using: .utf8)!
            return OHHTTPStubsResponse(data: data, statusCode: 500, headers: [:])
            
        }
    }
    
    private static func jsonFixture(with filename: String) -> OHHTTPStubsResponse {
        let bundle = OHResourceBundle("Fixtures", FixtureLoader.self)!
        let path = OHPathForFileInBundle(filename, bundle)!
        return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
    }
}
