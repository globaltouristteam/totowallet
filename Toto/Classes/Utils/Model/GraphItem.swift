//
//  GraphItem.swift
//  Toto
//
//  Created by Nhuan Vu on 7/29/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class GraphItem: JsonObject {
    
    var marketCapByAvailableSupply: Double?
    var priceBtc: Double?
    var priceUsd: Double?
    var timestamp: Double?
    var volumeUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case marketCapByAvailableSupply = "market_cap_by_available_supply"
        case priceBtc = "price_btc"
        case priceUsd = "price_usd"
        case timestamp = "timestamp"
        case volumeUsd = "volume_usd"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        marketCapByAvailableSupply = try values.decodeIfPresent(Double.self, forKey: .marketCapByAvailableSupply)
        priceBtc = try values.decodeIfPresent(Double.self, forKey: .priceBtc)
        priceUsd = try values.decodeIfPresent(Double.self, forKey: .priceUsd)
        timestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp)
        volumeUsd = try values.decodeIfPresent(Double.self, forKey: .volumeUsd)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(marketCapByAvailableSupply, forKey: .marketCapByAvailableSupply)
        try container.encodeIfPresent(priceBtc, forKey: .priceBtc)
        try container.encodeIfPresent(priceUsd, forKey: .priceUsd)
        try container.encodeIfPresent(timestamp, forKey: .timestamp)
        try container.encodeIfPresent(volumeUsd, forKey: .volumeUsd)
    }
    
}
