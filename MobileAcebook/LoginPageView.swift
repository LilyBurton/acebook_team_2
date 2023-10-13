//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 10/10/2023.
//

import SwiftUI


struct LoginPageView: View {
    @StateObject private var authenticationService = AuthenticationService()
    @StateObject private var postsService = PostsService(authenticationService: AuthenticationService())
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSecured: Bool = true
    @State private var errorMessage: String? = nil
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [ .orange, .white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                VStack(spacing: 40) {
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()
                    
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(25)
                    
                    
                    
                    HStack {
                        if isSecured == true {
                            SecureField("Password", text: $password)
                        } else {
                            TextField("Password" , text: $password)
                        }
                        
                        
                        Image(systemName: "eye.fill" )
                            .onTapGesture {
                                if isSecured {
                                    isSecured = false
                                } else {
                                    isSecured = true
                                }
                            }
                            .padding()
                    }
                    .padding(.leading)
                    .frame(width: 350)
                    .background(.white)
                    .cornerRadius(25)
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                    
                    
                    
                    Button (action: { self.loginUser()
                        
                        
                    })
                    {
                        Text("Submit")
                            .frame(width: 280, height: 50)
                            .background(.black.gradient)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .cornerRadius(25)
                    }
                    
                    NavigationLink("", destination: PostPageView(authenticationService: authenticationService, postsService: postsService), isActive: $isActive).hidden()
                    
                }
                .padding()
            }
        }
    }
    
    private func loginUser() {
        let userLog = UserLogin(email: email, password: password)
        postsService.loginAndFetchPosts(user: userLog) { success in
            if success {
                DispatchQueue.main.async {
                    self.email = ""
                    self.password = ""
                    self.isActive = true
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid username and/or password"
                }
            }
        }
    }
}
     
    
  

