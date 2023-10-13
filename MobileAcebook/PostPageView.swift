//
//  PostPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct PostPageView: View {
    
    
    let authenticationService: AuthenticationService
    @ObservedObject var postsService: PostsService
    
    init(authenticationService: AuthenticationService, postsService: PostsService) {
        self.authenticationService = authenticationService;
        self.postsService = postsService
    }
    
    @State private var postMessage = ""
    @State private var isSumbitPostViewShowing = false
    
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
                    postsService.getPosts()
    
                        }
                
                .padding(.horizontal)
                ScrollView {
                    HStack{
                        AsyncImage(url: URL(string: "https://example.com/icon.png"))
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .padding()
                        Spacer()
                        TextField("Penny for your thoughts", text:$postMessage)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                isSumbitPostViewShowing = true
                            }
                    }
                    
                    Spacer() // Pushes the Hello text to the top
                    
                    ForEach(postsService.posts) { post in
                        PostView(post: post, user: postsService.postUser ?? exampleUser)
                        }
            }
            }.sheet(isPresented: $isSumbitPostViewShowing) {
                SumbitPostView(postsService: PostsService(authenticationService: authenticationService))
            }
            .task {
                do {
                    try await postsService.getPosts()
                } catch {
                    print("Error loading posts")
                }
            }
        }
    
    }
        


struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView(authenticationService: AuthenticationService(), postsService: PostsService(authenticationService: AuthenticationService()))
    }
}


