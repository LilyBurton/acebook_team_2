//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct SignUpPageView: View {
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPass = ""
//    @State private var attachFile = ""
    @State private var isActive = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [ .blue, Color("lightblue")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack {
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()
                    
                    Form {
                        Section(header: Text("Sign Up")){
                            TextField("Email", text: $email)
                            TextField("Username", text: $username)
                            TextField("Password", text: $password)
                            TextField("Confirm Password", text: $confirmPass)
                        }
                    }
                    .frame(width: 400, height: 500)
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                    
                    Button(action: {
                        self.submitUser()
                        self.isActive = true
                    }) {
                        Text("Submit")
                            .frame(width: 280, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .cornerRadius(25)
                    }
                    NavigationLink("", destination: LoginView(), isActive: $isActive)
                    }
                }
            }
        }

    
    
    func submitUser() {
        if password == confirmPass {
            let user = User(email: email, username: username, password: password)
            authenticationService.signUp(user: user)
            email = ""
            username = ""
            password = ""
            confirmPass = ""
        } else {
            password = "Passwords do not match"
            confirmPass = ""
        }
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView(authenticationService: AuthenticationService())
    }
}
