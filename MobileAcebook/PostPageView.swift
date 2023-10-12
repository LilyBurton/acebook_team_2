//
//  PostPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct PostPageView: View {
    
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    @State private var post = ""
    var body: some View {
            VStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [ .orange, .white]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    HStack {
                        Image("makers-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .accessibilityIdentifier("makers-logo")
                        Spacer()
                        Button("Log Out") {
                            // Add log out action here
                        }
                        .accessibilityIdentifier("logOutButton")
                    }
                }
                .onAppear {
                            
                            authenticationService.getPosts()
                        }
                
                .padding(.horizontal)
                ScrollView {
                    HStack{
                        AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .padding()
                        Spacer()
                        TextField("Penny for your thoughts", text:$post)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    Text("Hello")
                    Spacer() // Pushes the Hello text to the top
                    
                    VStack {
                        HStack {
                            AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                                .clipShape(Circle())
                                .frame(width:30, height: 30)
                                .padding()
                            Text("Username")
                                .padding()
                            Spacer()
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(-90))
                                .padding()
                        }
                        HStack {
                            Text("This is where the comment will go need to align left and improve font")
                                .padding()
                        }
                        Image("colours")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 300)
                        HStack {
                            Image(systemName: "hand.thumbsup.circle.fill")
                                .foregroundStyle(.orange)
                                .padding(.leading)
                            Text("56")
                            Spacer()
                            
                            Text("200")
                            Image(systemName: "ellipsis.bubble.fill")
                                .foregroundStyle(.orange)
                                .padding(.trailing)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "hand.thumbsup")
                                .padding(.leading)
                            Text("Like")
                            
                            Spacer()
                            Text("Comment")
                            Image(systemName: "bubble.left")
                                .padding(.trailing)
                        }
                        .frame(height: 50)
                    
                        
                    }
                    
                
            }
                
                
                
                
//                // Add your scrollable content here
//                ForEach(1..<20) { i in
//                    Text("Item \(i)")
//                        .font(.largeTitle)
//                }
            }
        }
    }
        


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView(authenticationService: AuthenticationService())
    }
}


