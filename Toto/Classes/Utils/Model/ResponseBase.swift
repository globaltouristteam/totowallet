//
//  ResponseBase.swift
//  pegasuspax
//
//  Created by Nhuan Vu on 2/13/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

public class ResponseBase<T: JsonObject>: JsonObject {
    
    /// Response JsonObject array
    var list: [T]?
    
    enum CodingKeys: String, CodingKey {
        case list
    }
    override init() {
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([T].self, forKeys: [.list])
    }
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(list, forKey: .list)
    }
}

