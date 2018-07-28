//
//  TickerData.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TickerData: JsonObject {
    var tickerData: [Ticker] = []
    
    struct TickerDataCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container = try decoder.container(keyedBy: TickerDataCodingKeys.self)
        tickerData = container.decodeUnknownKeyValues()
    }
    override public func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        LogInfo("Encoder not implement yet")
    }
}

extension KeyedDecodingContainer where Key == TickerData.TickerDataCodingKeys {
    func decodeUnknownKeyValues() -> [Ticker] {
        var data = [Ticker]()
        
        for key in allKeys {
            if let value = try? decode(Ticker.self, forKey: key) {
                data.append(value)
            } else {
                LogInfo("Key \(key.stringValue) type not supported")
            }
        }
        return data
    }
}
