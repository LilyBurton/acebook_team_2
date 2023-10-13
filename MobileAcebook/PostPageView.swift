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
                                   startPoint: .top,
                                   endPoint: .bottom)
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
                    Text("Hello Rachel")
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
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                isSumbitPostViewShowing = true
                            }
                    }
                    
                    Spacer()
                    
                    VStack {

                        HStack {
                            Text("My latest art. What do you think?")
                                .multilineTextAlignment(.leading)
                        }
                        Image("colours")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
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
                        Divider()
                        
                    }
                    VStack {

                        HStack {
                            Text("This sold in less than an hour!!")
                                .multilineTextAlignment(.leading)
                        }
                        Image("prettycolours")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                        HStack {
                            Image(systemName: "hand.thumbsup.circle.fill")
                                .foregroundStyle(.orange)
                                .padding(.leading)
                            Text("32")
                            Spacer()
                            
                            Text("100")
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


