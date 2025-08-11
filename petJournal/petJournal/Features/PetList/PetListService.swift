import Foundation

protocol PetListServiceProtocol {
    static func fetchPets(completion: @escaping (Result<[PetModel], PetListingError>) -> Void)
}

class PetListService: PetListServiceProtocol {    
    static func fetchPets(completion: @escaping (Result<[PetModel], PetListingError>) -> Void) {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.pet) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.debugDataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case PetRegisterError.success.rawValue:
                guard let data = data else {
                    completion(.failure(PetListingError.invalidResponse))
                    return
                }
                
                do {
                    let pets = try JSONDecoder().decode([PetModel].self, from: data)
                    completion(.success(pets))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            case PetListingError.invalidRequest.rawValue:
                completion(.failure(.invalidRequest))
            case PetListingError.unauthorizedGuardian.rawValue:
                completion(.failure(.unauthorizedGuardian))
            default:
                completion(.failure(.internalServerError))
            }
        }.resume()
    }
}
