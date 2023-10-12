//
//  Post.swift
//  MobileAcebook
//
//  Created by Kumani Kidd on 11/10/2023.
//

struct ResponseData: Decodable {
    let posts: [Post]
    let user: PostUser
    let token: String
}

struct Post: Decodable {
    let message: String
    let likes: [String]
    let comments: Int
    let _id: String
    let createdAt: String
    let createdBy: String
    let __v: Int
    let image: String?
}

struct PostUser: Decodable {
    let username: String
    let avatar: String
    let _id: String
    let email: String
    let password: String
    let __v: Int
}
