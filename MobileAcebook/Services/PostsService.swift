//
//  PostsService.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 12/10/2023.
//

import Foundation

class PostsService: PostsServiceProtocol {
    
    var posts = [Post]()
    
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }

    
    func createPost(message: String) {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/posts")!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authenticationService.activeToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "message": message
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
               return
            }
            do {
                let response = try JSONDecoder().decode(Token.self, from: data)
                self.authenticationService.activeToken = response.token
                print(response)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    
    func getPosts() {
        guard let url = URL(string: "http://127.0.0.1:8080/posts") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authenticationService.activeToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ResponseData.self, from: data)
                let posts = decodedData.posts
                let user = decodedData.user
                
                self.authenticationService.activeToken = decodedData.token
                
                DispatchQueue.main.async {
                    self.posts = posts
                    print(posts)
                    print(user)
                }
            } catch {
                print("Decoding error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                       print("Received JSON: \(jsonString)")
                   }
            }
        }
        task.resume()
    }
}
