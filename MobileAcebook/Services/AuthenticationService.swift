//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    
    var activeToken = ""

    
    func signUp(user: User, completion: @escaping (String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": user.email,
            "username": user.username,
            "password": user.password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    print(jsonResponse)
                    if let message = jsonResponse["message"] as? String {
                        completion(message)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func login(user: UserLogin, closure: @escaping (Bool) -> Void) {
        
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/tokens")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": user.email,
            "password": user.password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                closure(false)
               return
            }
            do {
                let response = try JSONDecoder().decode(Token.self, from: data)
                self.activeToken = response.token
                print(self.activeToken)
                closure(true)
            }
            catch {
                print(error)
                closure(false)
            }
        }
        task.resume()
    }

}
