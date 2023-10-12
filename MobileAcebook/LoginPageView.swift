//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 10/10/2023.
//

import SwiftUI


struct loginPageView: View {
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSecured: Bool = true
    @State private var isActive = false
    
    var body: some View {
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
                
                //
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
                NavigationLink("", destination: PostPageView(authenticationService: authenticationService), isActive: $isActive)
                Spacer()
                
            }
        }
    }
    func loginUser() {
        let user = UserLogin(email: email, password: password)
        authenticationService.login(user: user) { success in
            if success {
                if !authenticationService.activeToken.isEmpty {
                    self.isActive = true
                } else {
                   
                }
            } else {
                
            }
        }
    }
}


struct loginPageView_Previews: PreviewProvider {
    static var previews: some View {
        loginPageView(authenticationService: AuthenticationService())
    }
}
