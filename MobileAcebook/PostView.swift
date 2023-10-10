//
//  PostView.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 09/10/2023.
//

import SwiftUI

struct PostView: View {
    @State private var post = ""
    var body: some View {
        ScrollView {
            VStack {
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
                .padding(.horizontal)
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

                // Add your scrollable content here
                ForEach(1..<20) { i in
                    Text("Item \(i)")
                        .font(.largeTitle)
                }
            }
        }
    }
        }


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
