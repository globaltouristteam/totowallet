//
//  TickersLoader.swift
//  Toto
//
//  Created by Nhuan Vu on 9/15/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

protocol TickersLoaderDelegate: class {
    func didLoad(tickers: [Ticker], refresh: Bool)
    
    func tickerOffset() -> Int
}

class TickersLoader: NSObject {
    weak var delegate: TickersLoaderDelegate?
    
    deinit {
        LogInfo("\(self)")
    }
    
    func start() {
        getTickers(refresh: true)
    }
    
    func getTickers(refresh: Bool) {
        guard let delegate = delegate else { return }
        let offset = refresh ? 0 : delegate.tickerOffset() + 1
        LogInfo("Starting: \(self) at \(offset)")
        HttpService.shared.getTickers(offset: offset) { [weak self] (tickers, error) in
            guard let `self` = self else { return }
            guard let tickers = tickers?.data?.tickerData else { return }
            self.delegate?.didLoad(tickers: tickers, refresh: refresh)
            if self.delegate != nil && tickers.count == 100 {
                self.getTickers(refresh: false)
            }
        }
    }
}
