//
//  PostPageView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct PostPageView: View {
    
    
    let authenticationService: AuthenticationService
    let postsService: PostsService
    let cloudName: String?
    
    
    
    init(authenticationService: AuthenticationService, postsService: PostsService) {
        self.authenticationService = authenticationService;
        self.postsService = postsService
        self.cloudName = ProcessInfo.processInfo.environment["CLOUD_NAME"]
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
                        AsyncImage(url: URL(string: "https://res.cloudinary.com/\(cloudName ?? "defaultCloudName")/image/upload/v1697135636/pmurtikblzn0mgpfip9b.jpg")) { phase in
                            if case .success(let image) = phase {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            } else {
                                // Handle other cases, e.g., placeholder, error, etc.
                                ProgressView()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .clipShape(Circle())
                            

                            .padding()
                        Spacer()
                        TextField("Penny for your thoughts", text:$postMessage)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                isSumbitPostViewShowing = true
                            }
                    }
                    Text("Hello")
                    Spacer() // Pushes the Hello text to the top
                    
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: "https://res.cloudinary.com/\(cloudName ?? "defaultCloudName")/image/upload/v1697135636/pmurtikblzn0mgpfip9b.jpg")) { phase in
                                if case .success(let image) = phase {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                } else {
                                    // Handle other cases, e.g., placeholder, error, etc.
                                    ProgressView()
                                        .frame(width: 30, height: 30)
                                }
                            }
                            .clipShape(Circle())
                                
                                .padding()
                            Text("Username")
                                .padding()
                            Spacer()
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(-90))
                                .padding()
                        }
                        HStack {
                            Text("Stuff")
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
            }.sheet(isPresented: $isSumbitPostViewShowing) {
                SumbitPostView(postsService: PostsService(authenticationService: authenticationService))
            }
        }
    
    }
        


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView(authenticationService: AuthenticationService(), postsService: PostsService(authenticationService: AuthenticationService()))
    }
}


