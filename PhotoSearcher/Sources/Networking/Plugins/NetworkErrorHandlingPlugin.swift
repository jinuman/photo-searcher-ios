//
//  NetworkErrorHandlingPlugin.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/16.
//

import Moya

struct NetworkErrorHandlingPlugin: PluginType {
    func process(
        _ result: Result<Response, MoyaError>,
        target _: TargetType
    ) -> Result<Response, MoyaError> {
        switch result {
        case let .success(response):
            guard !(200 ... 299).contains(response.statusCode) else {
                return result
            }
            return .failure(.statusCode(response))
        default: return result
        }
    }
}

extension Swift.Error {
    /// HTTP 상태 코드를 반환합니다. Moya를 통한 네트워킹인 경우에만 유효한 값을 얻을 수 있습니다.
    var httpStatusCode: Int? {
        return (self as? MoyaError)?.response?.statusCode
    }
}
