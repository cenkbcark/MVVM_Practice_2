//
//  PhotosResponseModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 7.10.2022.
//

import Foundation

struct PhotosResponseModel: Codable {
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
