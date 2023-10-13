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

struct Post: Identifiable, Decodable {

    let id: String
    let message: String
    let likes: [String]
    let comments: Int
    let createdAt: String
    let createdBy: String
    let __v: Int
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case message
        case likes
        case comments
        case createdAt
        case createdBy
        case __v
        case image
    }
}


struct PostUser: Identifiable, Decodable {
    let id: String
    let username: String
    let avatar: String
    let email: String
    let password: String
    let __v: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case avatar
        case email
        case password
        case __v
    }
}

