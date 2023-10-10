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
                    Spacer() // Pushes the Log Out button to the right
                    Button("Log Out") {
                        // Add your log out action here
                    }
                    .accessibilityIdentifier("logOutButton")
                }
                .padding(.horizontal)
                HStack{
                    AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                    
                    TextField("Penny for your thoughts", text:$post)
                    //                    .background(Color.blue)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding()
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
