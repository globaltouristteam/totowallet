//
//  NetworkingManager.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkingCompletionHandler = (_ result: NetworkingResult) -> Void
public typealias JsonObjectCompletionHandler<T: JsonObject> = ((_ response: T?, _ error: Error?) -> Void)
public typealias SuccessfulCompletionHandler = (_ error: Error?) -> Void

open class NetworkingManager {
    
    func submitRequest(params: NetworkingServiceParams, completionBlock: @escaping NetworkingCompletionHandler) {
        let reqId = UUID().uuidString
        LogDebug("\n\n", tag: reqId)
        LogDebug("\(params.requestMethod) Request start: \(params.requestURL)", tag: reqId)
        if let headers = params.requestHeader.headers().jsonString2() {
            LogDebug("Headers: \(headers)", tag: reqId)
        }
        if let params = params.requestParams.jsonString2() {
            LogDebug("Params: \(params)", tag: reqId)
        }
        
        let responseStringHandle: (DataResponse<String>) -> Void = { (response) in
            LogDebug("\n\n", tag: reqId)
            LogDebug("\(params.requestMethod) Request finish: \(response.request?.url?.absoluteString ?? "")", tag: reqId)
            if let error = response.result.error {
                LogError("Error: \(String(describing: error))", tag: reqId)
                self.handleErrorRequest(error, responseData: response.data, completionBlock: completionBlock)
            } else {
                var json: Any?
                if !StringUtils.isEmpty(response.result.value) {
                    LogDebug("Success: \(response.result.value!)", tag: reqId)
                    if let converted = response.result.value!.jsonData() {
                        if converted is Array<Any> {
                            json = ["list" : converted]
                        } else {
                            json = converted
                        }
                    }
                } else {
                    LogDebug("Success: Empty response", tag: reqId)
                }
                self.handleSuccessRequest(json, completionBlock: completionBlock)
            }
        }
        
        if params.requestMultipart == nil {
            let encoding: ParameterEncoding = params.json ? JSONEncoding.default : URLEncoding.default
            SessionManager.toto.request(params.requestURL,
                              method: params.requestMethod,
                              parameters: params.requestParams,
                              encoding: encoding,
                              headers: params.requestHeader.headers())
                .validate()
                .responseString(queue: nil,
                                encoding: String.Encoding.utf8,
                                completionHandler: responseStringHandle)
            
        } else {
            SessionManager.toto.upload(multipartFormData: { formData -> Void in
                params.requestMultipart?(formData)
                for (key, data) in params.requestParams {
                    var string: String?
                    if let data = data as? String {
                        string = data
                    } else if let data = data as? [String: Any] {
                        string = data.jsonString2()
                    } else {
                        string = "\(data)"
                    }
                    if let string = string {
                        formData.append(string.data(using: .utf8)!, withName: key)
                    }
                }
            },
                             to: params.requestURL,
                             method: params.requestMethod,
                             headers: params.requestHeader.headers(),
                             encodingCompletion: { [unowned self] (encodingResult) in
                                switch encodingResult {
                                case .success(let request, _, _):
                                    request
                                        .validate()
                                        .responseString(completionHandler: responseStringHandle)

                                case .failure(_):
                                    let errorMessage = "Multipart data encoding error"
                                    self.handleErrorRequest(TTError(errorMessage), completionBlock: completionBlock)
                                    LogError(errorMessage)
                                }
            })
        }
    }
    
    func handleSuccessRequest(_ response: Any?, completionBlock: @escaping NetworkingCompletionHandler) {
        if let response = response as? [String: Any] {
            runAtMain {
                completionBlock(NetworkingResult(responseData: response))
            }
        } else {
            runAtMain {
                completionBlock(NetworkingResult(responseData: ["response": response]))
            }
        }
    }
    
    func handleErrorRequest(_ error: Error, responseData: Data? = nil, completionBlock: @escaping NetworkingCompletionHandler) {
        runAtMain {
            completionBlock(NetworkingResult(error: error, data: responseData))
        }
    }
}

extension SessionManager {
    open static let toto: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        return SessionManager(configuration: configuration)
    }()
}
