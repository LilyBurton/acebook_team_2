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

    @State private var errorMessage: String? = nil
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
                            SecureField("Password", text: $password)
                            SecureField("Confirm Password", text: $confirmPass)
                        }
                        if let error = errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                        }
                    }
                    
                    
                    .frame(width: 400, height: 500)
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                    
                    Button(action: {
                        self.submitUser()
                        
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

    
    
    func isValidUserName() -> Bool {
        return username.count >= 5
    }
    
    func isValidPassword() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func submitUser() {
        if !isValidEmail(){
            errorMessage = "Please enter a valid email"
            return
        } else if !isValidPassword() {
            errorMessage = "Passwords must contain a special character,8 letters, a number and capital letter"
            return
        } else if !isValidUserName() {
            errorMessage = "Invalid Username"
            return
        } else if password == confirmPass {
            let user = User(email: email, username: username, password: password)
            authenticationService.signUp(user: user)
            email = ""
            username = ""
            password = ""
            confirmPass = ""
            errorMessage = nil
            self.isActive = true
        }
    }
    
    struct SignUpPageView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpPageView(authenticationService: AuthenticationService())
        }
    }
}
