//
//  NetworkingManager.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/16.
//

import PhotoSearcherFoundation
import PhotoSearcherReactive

public protocol NetworkingManagerProtocol {
    func request(
        _ target: SugarTargetType,
        file: String,
        function: StaticString,
        line: UInt
    ) -> Single<Response>
}

public extension NetworkingManagerProtocol {
    func request(
        _ target: SugarTargetType,
        file: String = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> Single<Response> {
        return self.request(target, file: file, function: function, line: line)
    }
}

public final class NetworkingManager: MoyaSugarProvider<MultiSugarTarget>, NetworkingManagerProtocol {

    public typealias Provider = MoyaProvider<MultiSugarTarget>
    public typealias RequestClosure = Provider.RequestClosure

    public init(
        requestClosure: @escaping RequestClosure,
        plugins: [PluginType]
    ) {
        let configuration = URLSessionConfiguration.default.then {
            $0.headers = [.defaultAcceptEncoding, .defaultAcceptLanguage]
            $0.timeoutIntervalForRequest = 10
        }
        let session = Session(configuration: configuration, startRequestsImmediately: false)

        super.init(requestClosure: requestClosure, session: session, plugins: plugins)
    }

    public func request(
        _ target: SugarTargetType,
        file: String,
        function: StaticString,
        line: UInt
    ) -> Single<Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        return self.rx.request(.target(target))
            .filterSuccessfulStatusCodes()
            .do(
                onSuccess: { value in
                    let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                    logger.debugPrint(message, file, function, line)
                    if let setCookie = value.response?.allHeaderFields["Set-Cookie"] {
                        logger.debugPrint("Set-Cookie: \(setCookie)")
                    }
                },
                onError: { error in
                    if let response = (error as? MoyaError)?.response {
                        if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                            logger.debugPrint(message, file, function, line, level: .error)
                        } else if let rawString = String(data: response.data, encoding: .utf8) {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                            logger.debugPrint(message, file, function, line, level: .error)
                        } else {
                            let message = "FAILURE: \(requestString) (\(response.statusCode))"
                            logger.debugPrint(message, file, function, line, level: .error)
                        }
                    } else {
                        let message = "FAILURE: \(requestString)\n\(error)"
                        logger.debugPrint(message, file, function, line, level: .warning)
                    }
                },
                onSubscribe: {
                    let message = "REQUEST: \(requestString)"
                    logger.debugPrint(message, file, function, line)
                }
            )
            .retryWhen { error in
                Self.retryWhenTrigger(with: error)
            }
    }

    private static func retryWhenTrigger(with error: Observable<Error>) -> Observable<Void> {
        let maxAttemptCount = 3

        return error.enumerated()
            .flatMap { index, error -> Observable<Void> in
                guard Self.isSoftwareCausedConnectionAbortError(error) else {
                    return .error(error)
                }

                let currentAttemptCount = index + 1
                if currentAttemptCount < maxAttemptCount {
                    return .just(Void())
                } else {
                    return .error(error)
                }
            }
    }

    /**
     iOS 12에서 UIApplication이 willEnterForeground 상태일 때 네트워크 요청을 보내면 발생하는 에러인 경우 `true`를 반환합니다.
     ```
     Error Domain=NSPOSIXErrorDomain Code=53 "Software caused connection abort"
     ```
     */
    private static func isSoftwareCausedConnectionAbortError(_ error: Error) -> Bool {
        if case let MoyaError.underlying(underlyingError, _) = error {
            return self.isSoftwareCausedConnectionAbortError(underlyingError)
        }
        let nsError = error as NSError
        return (nsError.domain, nsError.code) == (NSPOSIXErrorDomain, 53)
    }
}
