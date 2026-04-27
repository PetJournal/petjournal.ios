import Foundation
import os.log

extension URLSession {
    /// Performs a request with detailed debug logging for URL, headers, body, response and errors.
    func debugData(from url: URL) async throws -> (Data, URLResponse) {
        let request = URLRequest(url: url)
        return try await debugRequest(request)
    }

    /// Performs a URLRequest with detailed debug logging for URL, headers, body, response and errors.
    func debugRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let logger = Logger(subsystem: "com.podcaxt.network", category: "URLSession")
        let requestId = UUID().uuidString.prefix(8)
        
        logger.logRequest(request, id: String(requestId))

        do {
            let (data, response) = try await data(for: request)
            logger.logResponse(response, data: data, id: String(requestId))
            return (data, response)
        } catch {
            logger.logError(error, id: String(requestId))
            throw error
        }
    }
}

// MARK: - Logger Extension

private extension Logger {
    func logRequest(_ request: URLRequest, id: String) {
        #if !DEBUG
        return
        #endif
        var log = "🌐 📤 Request Debug 📤 [\(id)]🏷️\n"
        log += "🟣 URL: \(request.url?.absoluteString ?? "nil")\n"
        log += "🟣 Method: \(request.httpMethod ?? "GET")"

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            log += "\n🟣 Headers: \(headers.map { "\($0.key): \($0.value)" }.joined(separator: ", "))"
        }

        if let body = request.httpBody {
            log += "\n🟣 Body:\n"
            log += getBodyLog(body, contentType: request.value(forHTTPHeaderField: "Content-Type"))
        }
        
        self.debug("\(log)")
    }

    func getBodyLog(_ body: Data, contentType: String?) -> String {
        if let contentType,
           contentType.contains("multipart/form-data"),
           let boundary = contentType.components(separatedBy: "boundary=").last {
            return getMultipartBodyLog(body, boundary: boundary)
        } else if let string = String(data: body, encoding: .utf8) {
            return "🔹 \(string.prefix(500))"
        } else {
            return "🔹 [binary data: \(body.count) bytes]"
        }
    }

    func getMultipartBodyLog(_ body: Data, boundary: String) -> String {
        let parts = String(data: body, encoding: .ascii)?
            .components(separatedBy: "--\(boundary)")
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } ?? []

        var log = ""
        for part in parts {
            let components = part.components(separatedBy: "\r\n\r\n")
            guard components.count > 1 else { continue }

            let headers = components[0]
                .components(separatedBy: "\r\n")
                .filter { !$0.isEmpty }
                .map { "🔸 \($0)" }
                .joined(separator: "\n")

            let content = components[1...].joined(separator: "\r\n\r\n")
                .trimmingCharacters(in: .whitespacesAndNewlines)

            log += "\(headers)\n"

            if components[0].contains("image/jpeg") || components[0].contains("application/octet-stream") {
                log += "🔹 [binary data omitted]\n"
            } else if !content.isEmpty {
                log += "🔹 Content: \(content.prefix(200))\n"
            }
        }
        return log
    }

    func logResponse(_ response: URLResponse, data: Data, id: String) {
        #if !DEBUG
        return
        #endif
        var log = "🌐 📥 Response Debug 📥 [\(id)]🏷️\n"

        if let http = response as? HTTPURLResponse {
            log += "🟢 Status: \(http.statusCode)\n"
            if !http.allHeaderFields.isEmpty {
                log += "🟢 Headers: \(http.allHeaderFields.map { "\($0.key): \($0.value)" }.joined(separator: ", "))\n"
            }
        }

        log += "🟢 Data (\(data.count) bytes):\n"
        if let string = String(data: data, encoding: .utf8) {
            log += "🔹 \(string.prefix(500))"
        } else {
            log += "🔹 [binary data]"
        }
        
        self.debug("\(log)")
    }

    func logError(_ error: Error, id: String) {
        #if !DEBUG
        return
        #endif
        let log = "🌐 ❌ Error Debug ❌ [\(id)]🏷️\n🔴 Error: \(error.localizedDescription)"
        self.debug("\(log)")
    }
}
