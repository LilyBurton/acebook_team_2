//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    
    var activeToken = ""

    
    func signUp(user: User) {
        
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": user.email,
            "username": user.username,
            "password": user.password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
               return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Succces: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func login(user: UserLogin) {
        
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
               return
            }
            do {
                let response = try JSONDecoder().decode(Token.self, from: data)
                self.activeToken = response.token
                print(self.activeToken)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }

}
