//
//  UserAPI.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 6.10.2022.
//

import Foundation

protocol UserFetchable {
    func retriveUser(request: UserRequestModel, completion: @escaping (Result<[UserResponseModel], ApiError>) -> Void)
}

final class UserAPI: UserFetchable {
    
    private let networkManager : Networking
    
    init(networkManager: Networking){
        self.networkManager = networkManager
    }
    
    func retriveUser(request: UserRequestModel, completion: @escaping (Result<[UserResponseModel], ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
