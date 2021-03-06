//
//  LoggingManager.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/06.
//

public let logger = LoggingManager.shared

public final class LoggingManager {

    static let shared = LoggingManager()

    private init() {}

    public func debugPrint(
        _ message: @autoclosure () -> Any,
        _ file: String = #file,
        _ function: StaticString = #function,
        _ line: UInt = #line,
        context: Any? = nil,
        level: LoggingLevel = .debug
    ) {
        #if DEBUG
        print("\(self.timeStamp())\(level.prefix) \(self.fileInformation(file, function, line)) - \(message())")
        #endif
    }

    private func fileInformation(_ file: String, _ function: StaticString, _ line: UInt) -> String {
        guard let lastFile = file.components(separatedBy: "/").last,
              !lastFile.isEmpty else { return "No File" }
        return lastFile.replacingOccurrences(of: ".swift", with: "") + ".\(function)" + ":\(line)"
    }

    private func timeStamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "

        return dateFormatter.string(from: Date())
    }
}

public enum LoggingLevel {
    case verbose
    case debug
    case info
    case warning
    case error

    var prefix: String {
        switch self {
        case .verbose:
            return "💜 VERBOSE"
        case .debug:
            return "💚 DEBUG"
        case .info:
            return "💙 INFO"
        case .warning:
            return "💛 WARNING"
        case .error:
            return "❤️ ERROR"
        }
    }
}
