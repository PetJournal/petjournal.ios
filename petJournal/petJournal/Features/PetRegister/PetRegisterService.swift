import Foundation

protocol PetRegisterServiceProtocol {
    static func registerPet(petToBeRegistered: PetModel,
                     completion: @escaping(Result<PetModel, PetRegisterError>) -> Void)
}

class PetRegisterService: PetRegisterServiceProtocol {
    static func registerPet(petToBeRegistered: PetModel,
                     completion: @escaping(Result<PetModel, PetRegisterError>) -> Void) {
        
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petRegister) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        let fields: [String: Any] = [
            "specieName": petToBeRegistered.specie.name,
            "petName": petToBeRegistered.petName,
            "gender": petToBeRegistered.gender,
            "breedName": petToBeRegistered.breed.name,
            "size": petToBeRegistered.size.name,
            "castrated": petToBeRegistered.castrated,
            "dateOfBirth": petToBeRegistered.dateOfBirth
        ]
        
        for (key, value) in fields {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Adiciona o arquivo de imagem, se existir
        if let imageData = petToBeRegistered.image {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"pet_image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Finaliza o corpo
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.debugDataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                if (200...299).contains(httpResponse.statusCode) {
                    let decoder = JSONDecoder()
                    let responsePet = try decoder.decode(PetModel.self, from: data)
                    completion(.success(responsePet))
                } else {
                    switch httpResponse.statusCode {
                    case 400:
                        completion(.failure(.invalidRequest))
                    case 406:
                        completion(.failure(.notAccepted))
                    default:
                        completion(.failure(.internalServerError))
                    }
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
