//
//  Model.swift
//  AdoptMe
//
//  Created by zeke kim on 4/27/22.
//

import Foundation

struct AuthResponse: Decodable {
    let type: String
    let expiration: Int
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case type = "token_type"
        case expiration = "expires_in"
        case token = "access_token"
    }
}

struct Dogs: Decodable {
    let dogs: [Dog]
    
    enum CodingKeys: String, CodingKey {
        case dogs = "animals"
    }
}

struct Dog:Decodable {
    let url: String?
    //TODO: Better way to decode breeds, for rn my solution is -- let breeds: [Any]
    let age: String?
    let name: String?
    let description: String?
    let photos: [Photo]
    let contact: Contact?
    let status: String?
    
    enum CodingKeys:String, CodingKey {
        case url = "url"
        case age = "age"
        case name = "name"
        case description = "description"
        case photos = "photos"
        case contact = "contact"
        case status = "status"
    }
    
}

struct Photo:Decodable {
    let small: String?
    let medium: String?
    let large: String?
    let full: String?
    enum CodingKeys:String, CodingKey {
        case large = "large"
        case medium = "medium"
        case small = "small"
        case full = "full"
    }
}

struct Breeds: Decodable {
    let primary: String?
    let secondary: String?
    let mixed: Bool
    let unknown: Bool
    enum CodingKeys: String, CodingKey {
        case primary = "primary"
        case secondary = "secondary"
        case mixed = "mixed"
        case unknown = "unknown"
    }
}

struct Contact: Decodable {
    let email: String?
    let phone: String?
    let address: Address?
    
    enum CodingKeys:String, CodingKey {
        case email = "email"
        case phone = "phone"
        case address = "address"
    }
}

struct Address: Decodable {
    let city: String?
    let state: String?
    let postCode: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case state = "state"
        case postCode = "postcode"
        case country = "country"
    }
}
