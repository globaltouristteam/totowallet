//
//  Category.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class Category: JsonObject {
    var tours: [Tour] = []
    
    func isPopular() -> Bool {
        return false
    }
}