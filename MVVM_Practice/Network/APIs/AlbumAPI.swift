//
//  AlbumAPI.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 6.10.2022.
//

import Foundation

protocol AlbumFetchable {
    func retriveAlbum(request: AlbumRequestModel, completion: @escaping (Result<[AlbumResponseModel], ApiError>) -> Void)
}

final class AlbumAPI: AlbumFetchable {
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retriveAlbum(request: AlbumRequestModel, completion: @escaping (Result<[AlbumResponseModel], ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}

