//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct WelcomePageView: View {
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("Welcome to Acebook!")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("welcomeText")
                    
                    Spacer()
                    
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()
                    
                    NavigationLink(destination: SignUpPageView(authenticationService: authenticationService)) {
                        Text("Sign up")
                            .padding()
                    }
                    .accessibilityIdentifier("signUpButton")
                    
                    Button("Login") {
                        
                    }
                    .accessibilityIdentifier("loginButton")
                    
                    Spacer()
                }
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView(authenticationService: AuthenticationService())
    }
}
