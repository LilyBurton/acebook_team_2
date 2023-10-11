//
//  CommentView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 11/10/2023.
//

import SwiftUI

struct CommentView: View {
    
    @State private var comment = ""
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "hand.thumbsup.circle.fill")
                        .foregroundStyle(.orange)
                        .padding(.leading)
                    Text("56")
                    
                    Spacer()
                    
                    Text("Like")
                    Image(systemName: "hand.thumbsup")
                        .padding(.trailing)
                
                }
                HStack {
                    AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                        .frame(width:30, height: 30)
                        .padding(5)
                    Text("This will be where the comment goes it will be contained in a box, a spread across screen, will need some padding and other bits.")
                        .frame(maxWidth: 250)
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                }
                .padding(5)
                HStack {
                    AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                        .frame(width:30, height: 30)
                        .padding(5)
                    Text("This will be where the comment goes it will be contained in a box, a spread across screen, will need some padding and other bits.")
                        .frame(maxWidth: 250)
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                }
                .padding(5)
                
                Spacer()
                
                HStack{
                    AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                        .padding()
                    Spacer()
                    TextField("Penny for your thoughts", text:$comment)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
