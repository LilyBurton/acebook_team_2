//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 10/10/2023.
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
                LinearGradient(gradient: Gradient(colors: [ .orange, .white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
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
                    
                    
                    NavigationLink(destination: loginPageView(authenticationService: authenticationService)) {
                        Text("Login")
                            .frame(width: 280, height: 50)
                            .background(.black.gradient)
                            . foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .cornerRadius(25)
                            .accessibilityIdentifier("loginButton")
                        }
                    
                    NavigationLink(destination: SignUpPageView(authenticationService: authenticationService)) {
                        Text("Sign up")
                            . foregroundColor(.black)
                            .padding()
                    }
                    .accessibilityIdentifier("signUpButton")
                    
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

