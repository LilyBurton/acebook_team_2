//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct SignUpPageView: View {
    let authenticationService: AuthenticationService
    let uploader = CloudinaryUploader()
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPass = ""
    @State private var profilePublicId = ""
   
    
    @State private var errorMessage: String? = nil
    //    @State private var attachFile = ""
    @State private var isActive = false
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var inputImage: UIImage?
    
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [ .orange, .white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                Group {
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(25)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(25)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(25)
                    SecureField("Confirm Password", text: $confirmPass)
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(25)
                }
                HStack{
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                        VStack(spacing: 0) {
                               Text("Tap to")
                               Text("select a")
                               Text("profile")
                               Text("image")
        
                           }
                           .foregroundColor(.gray)
                           .padding(2)
                            
                        image?
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    
                    Button("Save") {
                        if let uiImage = self.inputImage {
                            uploader.upload(image: uiImage) { (publicId, error) in
                                if let error = error {
                                    print("Upload error: \(error.localizedDescription)")

                                } else if let publicId = publicId {
                                    print("Uploaded successfully with public ID: \(publicId)")
                                    profilePublicId = publicId
                                }
                            }
                        }
                    }
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                
        
                
                Button(action: {
                    self.submitUser()
                    
                }) {
                    Text("Submit")
                        .frame(width: 280, height: 50)
                        .background(.black.gradient)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(25)
                }
                NavigationLink("", destination: loginPageView(authenticationService: authenticationService), isActive: $isActive)
                
            }
            
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        
    }

    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
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
    
    func isPasswordMatch() -> Bool {
        return password == confirmPass
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
        } else if !isPasswordMatch(){
            errorMessage = "Passwords must match"
            return
        } else {
            let user = User(email: email, username: username, password: password, profilePublicId: profilePublicId)
            authenticationService.signUp(user: user){ message in
                if message == "Email address already exists" {
                    errorMessage = message
                } else if message == "OK" {
                    email = ""
                    username = ""
                    password = ""
                    confirmPass = ""
                    errorMessage = nil
                    self.isActive = true}
            }
        }
        
        
        struct SignUpPageView_Previews: PreviewProvider {
            static var previews: some View {
                SignUpPageView(authenticationService: AuthenticationService())
            }
        }
        
    }}


