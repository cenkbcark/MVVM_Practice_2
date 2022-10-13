//
//  PhotoDetailCell.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import UIKit

final class PhotoDetailCell: UICollectionViewCell {

    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func setPhoto(for photo: PhotosResponseModel) {
        guard let photo = photo.thumbnailUrl else {return}
        photoImageView.downloaded(from: photo)
    }
}
