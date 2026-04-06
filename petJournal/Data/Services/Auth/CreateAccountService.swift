protocol CreateAccountServiceProtocol {
    func registerUser(model: UserModel) async throws -> Bool
}

class CreateAccountService: CreateAccountServiceProtocol {
    func registerUser(model: UserModel) async throws -> Bool {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.signupURL) else {
            throw NetworkError.invalidURL
        }
        
        let body = RegisterRequestBody(
            firstName: model.firstName,
            lastName: model.lastName,
            email: model.email,
            password: model.password,
            passwordConfirmation: model.passwordConfirmation,
            phone: model.phone,
            isPrivacyPolicyAccepted: model.isPrivacyPolicyAccepted
        )
        
        do {
            let _: EmptyResponse = try await NetworkManager.shared.jsonRequest(
                url: url,
                method: .post,
                body: body
            )
            return true
        } catch {
            throw error
        }
    }
}
