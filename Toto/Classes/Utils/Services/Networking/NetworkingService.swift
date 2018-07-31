//
//  HttpService.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkingResponseHandler = (_ response: Any?) -> Any?

open class NetworkingService {
    
    public required init() {
    }

    public func callServer<T: JsonObject>(_ type: T.Type, _ params: NetworkingServiceParams, serviceCompletionBlock: JsonObjectCompletionHandler<T>?) {
        callServer(params, serviceCompletionBlock: { (result) in
            serviceCompletionBlock?(result.data as? T, result.error)
            
        }) { (response) -> Any? in
            if let response = response as? [String: Any] {
                return T.from(data: response)
            }
            return response
        }
    }
    
    public func callServer(_ params: NetworkingServiceParams, serviceCompletionBlock: NetworkingCompletionHandler?, responseHandler: NetworkingResponseHandler?) {
        /*
        if let _ = params.requestHeader as? SecureHeader {
            // Token empty or expires
            if !AppConfigManager.shared().accessToken.isValid() {
                refreshTokenAndRetry(params, serviceCompletionBlock: serviceCompletionBlock, responseHandler: responseHandler)
                return
            }
            
            // Token valid, start request
            header.accessToken = AppConfigManager.shared().accessToken.accessToken
            submitToServer(params, serviceCompletionBlock: { [unowned self] (result) in
                // 401. Refresh token
                if let error = result.error as? TTError {
                    if error.code == 401 {
                        self.refreshTokenAndRetry(params, serviceCompletionBlock: serviceCompletionBlock, responseHandler: responseHandler)
                        return
                    }
                }
                self.callService(completionBlock: serviceCompletionBlock, result: result)
                
            }, responseHandler: responseHandler)
        } else {
         */
           submitToServer(params, serviceCompletionBlock: serviceCompletionBlock, responseHandler: responseHandler)
        //}
    }
    
    func callService(completionBlock: NetworkingCompletionHandler?, result: NetworkingResult) {
        if let completionBlock = completionBlock {
            runAtMain {
                completionBlock(result)
            }
        }
    }
    
    /*
    /// Refresh token and retry request
    ///
    /// - Parameters:
    ///   - params: Main request params
    ///   - serviceCompletionBlock: Main request completion block
    ///   - responseHandler: Main request response handler
    ///   - retryCount: Refresh token retry count
    func refreshTokenAndRetry(_ params: NetworkingServiceParams,
                              serviceCompletionBlock: NetworkingCompletionHandler?,
                              responseHandler: NetworkingResponseHandler?,
                              retryCount: Int = 3) {
        
        refreshToken { (result) in
            if AppConfigManager.shared().accessToken.isValid() {
                return self.callServer(params, serviceCompletionBlock: serviceCompletionBlock, responseHandler: responseHandler)
            }

            if let error = result.error as? TTError, retryCount > 0 {
                switch error.cause {
                case "invalid_client"?, "invalid_grant"?:
                    break
                    
                default:
                    self.refreshTokenAndRetry(params, serviceCompletionBlock: serviceCompletionBlock, responseHandler: responseHandler, retryCount: retryCount - 1)
                    return
                }
            }
            
            serviceCompletionBlock?(result)
        }
    }
    
    func refreshToken(completionBlock: NetworkingCompletionHandler? = nil) {
        let config = AppConfigManager.shared()
        let params = NetworkingServiceParams()
        let phone = config.phoneNumber
        phone?.full = nil
        
        params.requestHeader = RequestHeader()
        params.requestMethod = .post
        params.json = true
        params.requestURL = config.serverUrl + "/oauth/app/token"
        params.requestParams = [
            "grant_type": "device_token",
            "device_token": config.deviceIME,
            "client_id": config.clientId,
            "client_secret": config.clientSecret,
            "phone": phone?.json() ?? [:]
        ]

        // swiftlint:disable multiline_arguments
        callServer(params, serviceCompletionBlock: { (result) in
            if let token = result.data as? AccessToken {
                token.updateCreatedDate()
                AppConfigManager.shared().accessToken = token
            }
            completionBlock?(result)

        }) { (response) -> Any? in
            if let response = response as? [String: Any] {
                return AccessToken.from(data: response)
            }
            return nil
        }
    }
 */
    
    fileprivate func submitToServer(_ params: NetworkingServiceParams, serviceCompletionBlock: NetworkingCompletionHandler?, responseHandler: NetworkingResponseHandler?) {
        let manager = NetworkingManager()
        manager.submitRequest(params: params) { [unowned self] (result) in
            if result.error == nil {
                if responseHandler != nil {
                    let resultParsed = responseHandler!(result.jsonData())
                    if let error = resultParsed as? Error {
                        result.error = error
                    } else {
                        result.data = resultParsed
                    }
                }
            }
            self.callService(completionBlock: serviceCompletionBlock, result: result)
        }
    }
}
