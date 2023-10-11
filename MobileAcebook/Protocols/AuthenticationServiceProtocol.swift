//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    func signUp(user: User, completion: @escaping (String?) -> Void)
    
    func login(user: UserLogin)
}
