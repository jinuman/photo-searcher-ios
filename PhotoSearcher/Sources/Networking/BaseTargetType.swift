//
//  BaseTargetType.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/16.
//

import Moya

protocol BaseTargetType: TargetType {
    var customHeaders: [String: String]? { get }
    var route: Route { get }
}

extension BaseTargetType {
    var headers: [String: String]? {
        return NetworkingContext.httpHeaders + (self.customHeaders ?? [:])
    }

    var customHeaders: [String: String]? {
        return nil
    }

    var baseURL: URL {
        return NetworkingContext.flickrBaseURL
    }

    var path: String {
        return self.route.path
    }

    var method: Moya.Method {
        return self.route.method
    }

    var sampleData: Data {
        return Data()
    }
}

private extension Dictionary {
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        var result = lhs
        rhs.forEach { result[$0.key] = $0.value }
        return result
    }
}

/// Reference from MoyaSugar
enum Route {
    case get(String)
    case post(String)
    case put(String)
    case delete(String)
    case options(String)
    case head(String)
    case patch(String)
    case trace(String)
    case connect(String)

    var path: String {
        switch self {
        case let .get(path): return path
        case let .post(path): return path
        case let .put(path): return path
        case let .delete(path): return path
        case let .options(path): return path
        case let .head(path): return path
        case let .patch(path): return path
        case let .trace(path): return path
        case let .connect(path): return path
        }
    }

    var method: Moya.Method {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        case .options: return .options
        case .head: return .head
        case .patch: return .patch
        case .trace: return .trace
        case .connect: return .connect
        }
    }
}
