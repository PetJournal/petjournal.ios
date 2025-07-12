import Foundation

extension URLSession {
    func debugDataTask(with request: URLRequest,
                      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        print("\n🌐 Request Debug:")
        print("URL: \(request.url?.absoluteString ?? "nil")")
        print("Method: \(request.httpMethod ?? "nil")")
        
        if let headers = request.allHTTPHeaderFields {
            print("Headers:")
            headers.forEach { print("  \($0.key): \($0.value)") }
        }
        
        if let body = request.httpBody {
            print("Body:")
            if let json = try? JSONSerialization.jsonObject(with: body, options: []),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            } else {
                print(String(data: body, encoding: .utf8) ?? "Can't decode body")
            }
        }
        
        return dataTask(with: request) { data, response, error in
            print("\n🔵 Response Debug:")
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                print("Headers:")
                httpResponse.allHeaderFields.forEach { print("  \($0.key): \($0.value)") }
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let data = data {
                print("Response Data:")
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                } else {
                    print(String(data: data, encoding: .utf8) ?? "Can't decode response data")
                }
            }
            
            completionHandler(data, response, error)
        }
    }
}
