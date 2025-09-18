import Foundation

extension URLSession {
    /// Executa uma requisição com logging detalhado
    func debugRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        #if DEBUG
        // MARK: - Request Logging
        print("\n🌐 ===== 📤 Request Debug 📤 ==== 🌐")
        print("🟣 URL: \(request.url?.absoluteString ?? "nil")")
        print("🟣 Method: \(request.httpMethod ?? "nil")")
        
        // MARK: - Headers Processing
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("🟣 Headers: \(headers.map { "\($0.key): \($0.value)" }.joined(separator: ", "))")
        }
        
        // MARK: - Body Processing
        if let body = request.httpBody {
            print("🟣 Body:")
            
            // Multipart form data processing
            if let contentType = request.value(forHTTPHeaderField: "Content-Type"),
               contentType.contains("multipart/form-data"),
               let boundary = contentType.components(separatedBy: "boundary=").last {
                
                let parts = String(data: body, encoding: .ascii)?
                    .components(separatedBy: "--\(boundary)")
                    .filter { !$0.trimmed.isEmpty } ?? []
                
                for part in parts {
                    let components = part.components(separatedBy: "\r\n\r\n")
                    guard components.count > 1 else { continue }
                    
                    let headers = components[0]
                    let content = components[1...].joined(separator: "\r\n\r\n").trimmed
                    
                    let headerLines = headers.components(separatedBy: "\r\n")
                        .filter { !$0.isEmpty }
                        .map { "🔸 \($0)" }
                        .joined(separator: "\n")
                    
                    print(headerLines)
                    
                    if headers.contains("image/jpeg") || headers.contains("application/octet-stream") {
                        print("🔹 [binary data omitted]")
                    } else if !content.isEmpty {
                        print("🔹 Content: \(content.prefix(200))")
                    }
                }
            }
            else if let bodyString = String(data: body, encoding: .utf8) {
                print("🔹 \(bodyString.prefix(500))")
            }
            else {
                print("🔹 [binary data: \(body.count) bytes]")
            }
        }
        #endif
        
        do {
            let (data, response) = try await data(for: request)
            
            #if DEBUG
            // MARK: - Response Logging
            print("\n🌐 ===== 📥 Response Debug 📥 ==== 🌐")
            
            if let httpResponse = response as? HTTPURLResponse {
                print("🟢 Status: \(httpResponse.statusCode)")
                if !httpResponse.allHeaderFields.isEmpty {
                    print("🟢 Headers: \(httpResponse.allHeaderFields.map { "\($0.key): \($0.value)" }.joined(separator: ", "))")
                }
            }
            
            print("🟢 Data (\(data.count) bytes):")
            if let string = String(data: data, encoding: .utf8) {
                print("🔹 \(string.prefix(500))")
            } else {
                print("🔹 [binary data]")
            }
            
            print("═══════════════════════════════════════")
            #endif
            
            return (data, response)
        } catch {
            #if DEBUG
            print("\n🌐 ===== ❌ Error Debug ❌ ==== 🌐")
            print("🔴 Error: \(error.localizedDescription)")
            print("═══════════════════════════════════════")
            #endif
            
            throw error
        }
    }
}
