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
        // Imprime cabeçalho de debug da requisição
        print("\n🌐 Request Debug:")
        // Mostra a URL da requisição
        print("URL: \(request.url?.absoluteString ?? "nil")")
        // Mostra o método HTTP (GET, POST, etc)
        print("Method: \(request.httpMethod ?? "nil")")
        
        // Mostra os headers da requisição, se existirem
        if let headers = request.allHTTPHeaderFields {
            print("Headers:")
            headers.forEach { print("  \($0.key): \($0.value)") }
        }
        
        // Mostra o corpo da requisição, se existir
        if let body = request.httpBody {
            print("Body:")
            // Tenta converter o corpo para JSON formatado
            if let json = try? JSONSerialization.jsonObject(with: body, options: []),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            } else {
                // Se não for JSON, tenta mostrar como string simples
                print(String(data: body, encoding: .utf8) ?? "Can't decode body")
            }
        }
        #endif
        
        // Cria e retorna a data task com logging da resposta
        return dataTask(with: request) { data, response, error in
            #if DEBUG
            // Imprime cabeçalho de debug da resposta
            print("\n🔵 Response Debug:")
            
            // Mostra detalhes da resposta HTTP, se disponível
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                print("Headers:")
                httpResponse.allHeaderFields.forEach { print("  \($0.key): \($0.value)") }
            }
            
            // Mostra erros, se existirem
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            // Mostra os dados da resposta, se existirem
            if let data = data {
                print("Response Data:")
                // Tenta converter a resposta para JSON formatado
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                } else {
                    // Se não for JSON, tenta mostrar como string simples
                    print(String(data: data, encoding: .utf8) ?? "Can't decode response data")
                }
            }
            #endif
            
            // Chama o completion handler original com os dados recebidos
            completionHandler(data, response, error)
        }
    }
}
