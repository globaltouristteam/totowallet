//
//    TicketResponse.swift
//    Copyright © 2018 Toto. All rights reserved.

import Foundation

class TicketResponse: JsonObject {
    
    var data: TickerData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TickerData.self, forKey: .data)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
    }
    
}
