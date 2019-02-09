//
//  RequestType.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import Alamofire
import RxSwift
import RxAlamofire

public protocol RequestProtocol {
    var url: URLConvertible { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

public func json(request: RequestProtocol) -> Observable<Any> {
    return json(request.method,
                request.url,
                parameters: request.parameters,
                encoding: request.encoding,
                headers: request.headers)
}

public enum RequestError: Error {
    case mappingFailed
}
