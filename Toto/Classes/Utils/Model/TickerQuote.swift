//
//    TickerQuote.swift
//    Copyright © 2018 Toto. All rights reserved.

import Foundation

class TickerQuote: JsonObject {
    
    var marketCap: Float?
    var percentChange1h: Float?
    var percentChange24h: Float?
    var percentChange7d: Float?
    var price: Float?
    var volume24h: Float?
    
    enum CodingKeys: String, CodingKey {
        case marketCap = "market_cap"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
        case price = "price"
        case volume24h = "volume_24h"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        marketCap = try values.decodeIfPresent(Float.self, forKey: .marketCap)
        percentChange1h = try values.decodeIfPresent(Float.self, forKey: .percentChange1h)
        percentChange24h = try values.decodeIfPresent(Float.self, forKey: .percentChange24h)
        percentChange7d = try values.decodeIfPresent(Float.self, forKey: .percentChange7d)
        price = try values.decodeIfPresent(Float.self, forKey: .price)
        volume24h = try values.decodeIfPresent(Float.self, forKey: .volume24h)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(marketCap, forKey: .marketCap)
        try container.encodeIfPresent(percentChange1h, forKey: .percentChange1h)
        try container.encodeIfPresent(percentChange24h, forKey: .percentChange24h)
        try container.encodeIfPresent(percentChange7d, forKey: .percentChange7d)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(volume24h, forKey: .volume24h)
    }
    
}
