//
//  API.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 6.10.2022.
//

import Foundation

extension Constant {
    
    class API {
        
        private init() { }
        static let baseURL = "https://jsonplaceholder.typicode.com"
        static let users = "/users"
        static let albums = "/albums"
        static let photos = "/photos"
    }
}
