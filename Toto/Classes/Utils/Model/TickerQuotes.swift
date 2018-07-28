//
//  TickerQuotes.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TickerQuotes: JsonObject {
    var tickerQuotes: [String: TickerQuote] = [:]
    
    struct TickerQuotesCodingKeys: CodingKey {
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
        
        let container = try decoder.container(keyedBy: TickerQuotesCodingKeys.self)
        tickerQuotes = container.decodeUnknownKeyValues()
    }
    override public func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        LogInfo("Encoder not implement yet")
    }
    
    func with(currency: String) -> TickerQuote {
        if let a = tickerQuotes[currency] {
            return a
        }
        if let a = tickerQuotes["USD"] {
            return a
        }
        return tickerQuotes.first!.value
    }
}

extension KeyedDecodingContainer where Key == TickerQuotes.TickerQuotesCodingKeys {
    func decodeUnknownKeyValues() -> [String: TickerQuote] {
        var data = [String: TickerQuote]()
        
        for key in allKeys {
            if let value = try? decode(TickerQuote.self, forKey: key) {
                data[key.stringValue] = value
            } else {
                LogInfo("Key \(key.stringValue) type not supported")
            }
        }
        
        return data
    }
}
