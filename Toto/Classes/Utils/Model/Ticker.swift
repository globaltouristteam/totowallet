//
//    Ticker.swift
//    Copyright © 2018 Toto. All rights reserved.

import Foundation

class Ticker: JsonObject {
    
    var circulatingSupply: Float?
    var id: Int?
    var lastUpdated: Int?
    var maxSupply: Float?
    var name: String?
    var quotes: TickerQuotes?
    var rank: Int?
    var symbol: String?
    var totalSupply: Float?
    var websiteSlug: String?
    
    enum CodingKeys: String, CodingKey {
        case circulatingSupply = "circulating_supply"
        case id = "id"
        case lastUpdated = "last_updated"
        case maxSupply = "max_supply"
        case name = "name"
        case quotes
        case rank = "rank"
        case symbol = "symbol"
        case totalSupply = "total_supply"
        case websiteSlug = "website_slug"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        circulatingSupply = try values.decodeIfPresent(Float.self, forKey: .circulatingSupply)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        lastUpdated = try values.decodeIfPresent(Int.self, forKey: .lastUpdated)
        maxSupply = try values.decodeIfPresent(Float.self, forKey: .maxSupply)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        quotes = try values.decodeIfPresent(TickerQuotes.self, forKey: .quotes)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        totalSupply = try values.decodeIfPresent(Float.self, forKey: .totalSupply)
        websiteSlug = try values.decodeIfPresent(String.self, forKey: .websiteSlug)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(circulatingSupply, forKey: .circulatingSupply)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(lastUpdated, forKey: .lastUpdated)
        try container.encodeIfPresent(maxSupply, forKey: .maxSupply)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(quotes, forKey: .quotes)
        try container.encodeIfPresent(rank, forKey: .rank)
        try container.encodeIfPresent(symbol, forKey: .symbol)
        try container.encodeIfPresent(totalSupply, forKey: .totalSupply)
        try container.encodeIfPresent(websiteSlug, forKey: .websiteSlug)
    }
    
}
