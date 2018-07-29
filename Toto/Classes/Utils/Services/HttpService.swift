//
//  HttpService.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class HttpService: NetworkingService {
    static let shared = HttpService()
    
    public func getTickers(offset: Int = 0, completionBlock: JsonObjectCompletionHandler<TicketResponse>?) {
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = serverUrl() + "/ticker"
        params.json = false
        params.requestParams = [
            "convert": "BTC",
            "limit": 100,
            "sort": "rank",
            "start": offset
        ]
        callServer(TicketResponse.self, params, serviceCompletionBlock: completionBlock)
    }
    
    func getGraphData(range: TickerGraphRange, coin: String, completionBlock: JsonObjectCompletionHandler<ResponseBase<GraphItem>>?) {
        let now = Date()
        
        let timestampEnd = round(now.timeIntervalSince1970)*1000
        
        var startDate: Date? = nil
        var timestampStart: Double = 0
        switch range {
        case .all:
            timestampStart = 1367174841000
        case .oneD:
            startDate = Calendar.current.date(byAdding: .day, value: -1, to: now)
        case .oneW:
            startDate = Calendar.current.date(byAdding: .day, value: -7, to: now)
        case .oneM:
            startDate = Calendar.current.date(byAdding: .day, value: -30, to: now)
        case .threeM:
            startDate = Calendar.current.date(byAdding: .day, value: -90, to: now)
        case .sixM:
            startDate = Calendar.current.date(byAdding: .day, value: -180, to: now)
        case .oneY:
            startDate = Calendar.current.date(byAdding: .day, value: -365, to: now)
        }
        if let date = startDate {
            timestampStart = round(date.timeIntervalSince1970)*1000
        }
        
        let params = NetworkingServiceParams()
        params.requestMethod = .get
        params.requestURL = String(format: "https://graphs2.coinmarketcap.com/currencies/%@/%0.0f/%0.0f", coin, timestampStart, timestampEnd)
        params.json = false
        print(params.requestURL)
        
        callServer(params, serviceCompletionBlock: { (result) in
            if let array = result.data as? [GraphItem] {
                let response = ResponseBase<GraphItem>()
                response.list = array
                completionBlock?(response, nil)
            } else {
                completionBlock?(nil, result.error)
            }
        }) { (response) -> Any? in
            guard let response = response as? [String: [[Double]]] else { return nil }
            guard let availableSupply = response["market_cap_by_available_supply"],
                let priceBtc = response["price_btc"],
                let priceUsd = response["price_usd"],
                let volumeUsd = response["volume_usd"],
                availableSupply.count == priceBtc.count && priceBtc.count == priceUsd.count && priceUsd.count == volumeUsd.count else {
                return nil
            }
            
            var result = [GraphItem]()
            for i in 0..<availableSupply.count {
                let item = GraphItem()
                item.timestamp = availableSupply[i].first
                item.marketCapByAvailableSupply = availableSupply[i].last
                item.priceBtc = priceBtc[i].last
                item.priceUsd = priceUsd[i].last
                item.volumeUsd = volumeUsd[i].last
                result.append(item)
            }
            return result
        }
    }
}
