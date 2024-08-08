//
//  UserModel.swift
//  MyAppCDMX
//
//  Created by Fernández González Rodrigo Arturo on 08/08/24.
//

import Foundation

struct UserModel: Codable {
    let users: [User]
}

//Visible
struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let email: String
    let image: String
    var favorite: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case age
        case gender
        case email
        case image
        
        // Set a default value key for favorite
        case defaultFavorite = "favorite"
    }
    
    init(id: Int, firstName: String, lastName: String, age: Int, gender: String, email: String, image: String, favorite: Bool? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
        self.email = email
        self.image = image
        self.favorite = favorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        age = try container.decode(Int.self, forKey: .age)
        gender = try container.decode(String.self, forKey: .gender)
        email = try container.decode(String.self, forKey: .email)
        image = try container.decode(String.self, forKey: .image)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .defaultFavorite) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(age, forKey: .age)
        try container.encode(gender, forKey: .gender)
        try container.encode(email, forKey: .email)
        try container.encode(image, forKey: .image)
        try container.encodeIfPresent(favorite, forKey: .defaultFavorite)
    }
}
