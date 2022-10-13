//
//  UserResponseModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 7.10.2022.
//

import Foundation

struct UserResponseModel: Codable {
    let id: Int?
    let name: String?
    let userName: String?
    let email: String?
    let adress: Adress?
    let phone: String?
    let website: String?
    let company: Company?
}

struct Adress: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let geo: Location?
}

struct Location: Codable {
    let lat: String?
    let lng: String?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
