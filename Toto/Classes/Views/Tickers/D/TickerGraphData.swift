//
//  TickerGraphData.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

typealias TickerGraphDataCompletionHandler = ((_ response: [GraphItem]) -> Void)

enum TickerGraphRange: Int {
    case oneD = 0
    case oneW
    case oneM
    case threeM
    case sixM
    case oneY
    case all
}

class TickerGraphData: NSObject {
    var coin: String = ""
    var current: TickerGraphRange = .oneD
    
    var cached: [TickerGraphRange: [GraphItem]] = [:]
    
    func currentCached() -> [GraphItem] {
        return cached[current] ?? []
    }
    
    func getData(range: TickerGraphRange, completionBlock: TickerGraphDataCompletionHandler?) {
        if let data = cached[range] {
            completionBlock?(data)
            return
        }
        HttpService.shared.getGraphData(range: range, coin: coin) { [weak self] (response, error) in
            guard let `self` = self else { return }
            if let data = response?.list {
                self.cached[range] = data
                completionBlock?(data)
                return
            }
            completionBlock?([])
        }
    }
}
