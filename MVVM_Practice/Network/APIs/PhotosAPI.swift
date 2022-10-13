//
//  PhotosAPI.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 7.10.2022.
//

import Foundation

protocol PhotosFetchable {
    func retrieveAlbum(request: PhotosRequestModel, completion: @escaping (Result<[PhotosResponseModel], ApiError>) -> Void)
}

final class PhotosAPI: PhotosFetchable {
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveAlbum(request: PhotosRequestModel, completion: @escaping (Result<[PhotosResponseModel], ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
