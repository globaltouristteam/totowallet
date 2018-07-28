//
//  TickerGraphData.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

enum TickerGraphRange: Int {
    case today = 0
    case oneW
    case oneM
    case threeM
    case sixM
    case oneY
    case all
}

class TickerGraphData: NSObject {
    var current: TickerGraphRange = .today
    
    
}
