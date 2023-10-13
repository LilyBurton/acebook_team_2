//
//  SumbitPostView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 12/10/2023.
//

import SwiftUI



struct SumbitPostView: View {
    
    let postsService: PostsService
    let cloudName: String?
    
    init(postsService: PostsService) {
        self.postsService = postsService
        self.cloudName = ProcessInfo.processInfo.environment["CLOUD_NAME"]
    }
    
    
    @State private var text = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [ .orange, .white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                HStack {
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
                    
                    Text("Username")
                    
                    Spacer()
                }
                
                
                
                TextField("Penny for your thoughts", text: $text,  axis: .vertical)
                    .lineLimit(5...10)
                    .padding()
                
                Spacer()
                Button(action: {self.createPost()})  {
                    Text("Create Post")
                        .frame(width: 280, height: 50)
                        .background(.black.gradient)
                        . foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(25)
                        .accessibilityIdentifier("loginButton")
                        .padding(.bottom, 100)
                }
            }
            }
        
    }
    
    func createPost() {
           postsService.createPost(message: text)
           PostPageView(authenticationService: AuthenticationService(), postsService: PostsService(authenticationService: AuthenticationService()))
       }
}

struct SumbitPostView_Preview: PreviewProvider {
    static var previews: some View {
        SumbitPostView(postsService: PostsService(authenticationService: AuthenticationService()))
    }
}
