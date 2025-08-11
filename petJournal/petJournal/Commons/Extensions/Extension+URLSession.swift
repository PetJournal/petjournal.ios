import Foundation

extension URLSession {
    /// Cria e retorna uma URLSessionDataTask com logs detalhados da requisição e resposta
    /// - Parameters:
    ///   - request: O objeto URLRequest contendo os detalhes da requisição
    ///   - completionHandler: Closure de completion que recebe os dados da resposta, a resposta em si e possíveis erros
    /// - Returns: Uma URLSessionDataTask pronta para ser executada
    func debugDataTask(with request: URLRequest,
                      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
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
                
                // Split into parts using boundary
                let parts = String(data: body, encoding: .ascii)?
                    .components(separatedBy: "--\(boundary)")
                    .filter { !$0.trimmed.isEmpty } ?? []
                
                for part in parts {
                    // Split into headers and content
                    let components = part.components(separatedBy: "\r\n\r\n")
                    guard components.count > 1 else { continue }
                    
                    let headers = components[0]
                    let content = components[1...].joined(separator: "\r\n\r\n").trimmed
                    
                    // Print headers compactly
                    let headerLines = headers.components(separatedBy: "\r\n")
                        .filter { !$0.isEmpty }
                        .map { "🔸 \($0)" }
                        .joined(separator: "\n")
                    
                    print(headerLines)
                    
                    // Handle content based on type
                    if headers.contains("image/jpeg") || headers.contains("application/octet-stream") {
                        print("🔹 [binary data omitted]")
                    } else if !content.isEmpty {
                        print("🔹 Content: \(content.prefix(200))") // Show beginning of non-binary content
                    }
                }
            }
            // JSON or plain text
            else if let bodyString = String(data: body, encoding: .utf8) {
                print("🔹 \(bodyString.prefix(500))") // Limit output length
            }
            // Binary data
            else {
                print("🔹 [binary data: \(body.count) bytes]")
            }
        }
        #endif
        
        // MARK: - Task Execution
        return dataTask(with: request) { data, response, error in
            #if DEBUG
            // MARK: - Response Logging
            print("\n🌐 ===== 📥 Response Debug 📥 ==== 🌐")
            
            if let httpResponse = response as? HTTPURLResponse {
                print("🟢 Status: \(httpResponse.statusCode)")
                if !httpResponse.allHeaderFields.isEmpty {
                    print("🟢 Headers: \(httpResponse.allHeaderFields.map { "\($0.key): \($0.value)" }.joined(separator: ", "))")
                }
            }
            
            if let error = error {
                print("🔴 Error: \(error.localizedDescription)")
            }
            
            if let data = data {
                print("🟢 Data (\(data.count) bytes):")
                if let string = String(data: data, encoding: .utf8) {
                    print("🔹 \(string.prefix(500))") // Limit output length
                } else {
                    print("🔹 [binary data]")
                }
            }
            
            print("═══════════════════════════════════════")
            #endif
            
            completionHandler(data, response, error)
        }
    }
}
