//
//  NetworkingLoggingPlugin.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/16.
//

import Moya

struct NetworkingLoggingPlugin: PluginType {
    func willSend(
        _ request: RequestType,
        target _: TargetType
    ) {
        let headers = request.request?.allHTTPHeaderFields ?? [:]
        let urlPath: String = request.request?.url?.absoluteString ?? ""
        let method = request.request?.httpMethod ?? ""

        #if DEBUG
            print("\n==================================================")
            print("➡️ [ \(method) ] \(urlPath)")
            print("👤 [ Headers ] \(headers)")
            if let body = request.request?.httpBody {
                let bodyString = String(bytes: body, encoding: String.Encoding.utf8) ?? ""
                print("🧴 [ Body ] \(bodyString)")
            }
            print("--------------------------------------------------\n")
        #endif
    }

    #if DEBUG
        func didReceive(
            _ result: Result<Response, MoyaError>,
            target _: TargetType
        ) {
            switch result {
            case let .success(response):
                print("\n==============================")
                print("📞 ( Response ) \(response.debugDescription)")
                print("------------------------------\n")
            case let .failure(error):
                print("\n==============================")

                print("🚫 ( Error ) \(error.errorDescription ?? error.localizedDescription)")
                print("------------------------------\n")
            }
        }
    #endif
}
