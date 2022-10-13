//
//  PhotosRequestModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 7.10.2022.
//

import Foundation

final class PhotosRequestModel: RequestModel {
    
    private let albumId: Int
    
    init(albumId: Int) {
        self.albumId = albumId
    }
    
    override var path: String {
        Constant.API.photos
    }
    
    override var method: RequestMethod {
        .get
    }
    
    override var parameters: [String : Any?] {
        [
            "albumId": String(self.albumId)
        ]
    }
}
