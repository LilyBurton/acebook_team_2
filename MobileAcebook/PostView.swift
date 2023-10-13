//
//  PostView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 12/10/2023.
//

import SwiftUI

struct PostView: View {
    let post: Post
    let user: PostUser
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: user.avatar))
                    .clipShape(Circle())
                    .frame(width:30, height: 30)
                    .padding()
                Text(user.username)
                    .padding()
                Spacer()
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(-90))
                    .padding()
            }
            HStack {
                Text(post.message)
                    .padding()
            }
            if (post.image != nil) {
                AsyncImage(url: URL(string: post.image!), content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 350, maxHeight: 300)
                },
                           placeholder: {
                        Image(systemName: "face.smiling")
                })
                    
            }
                
            HStack {
                Image(systemName: "hand.thumbsup.circle.fill")
                    .foregroundStyle(.orange)
                    .padding(.leading)
                Text("56")
                Spacer()
                
                Text(String(post.comments))
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
        }.padding()
        }
    
}
    
    
    
    let examplePost = Post(
        id: "1",
        message: "This is a test post",
        likes: [],
        comments: 10,
        createdAt: "2022-01-01T00:00:00Z",
        createdBy: "user1",
        __v: 0,
        image: "https://unsplash.com/photos/U1iYwZ8Dx7k"
    )
    
    let exampleUser = PostUser(
        id: "user1",
        username: "ExampleUser",
        avatar: "https://example.com/avatar.jpg",
        email: "user@example.com",
        password: "password",
        __v: 0
    )
    
    
    struct PostView_Previews: PreviewProvider {
        static var previews: some View {
            PostView(post: examplePost, user: exampleUser)
                
        }
    }
