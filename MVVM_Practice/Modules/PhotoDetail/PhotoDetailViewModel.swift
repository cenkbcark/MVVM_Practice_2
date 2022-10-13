//
//  PhotoDetailViewModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import Foundation

protocol PhotoDetailViewModelInput {
    var output: PhotoDetailViewModelOutput? { get set }
    func viewDidLoad()
    func retrievePhotoList(for album: AlbumResponseModel)
}

protocol PhotoDetailViewModelOutput: AnyObject {
    func home(_ viewModel: PhotoDetailViewModelInput, photoListDidLoad list: [PhotosResponseModel])
}

final class PhotoDetailViewModel: PhotoDetailViewModelInput {
    
    var photoList: [PhotosResponseModel] = []
    private let photoAPI: PhotosFetchable
    var album: AlbumResponseModel?
    var output: PhotoDetailViewModelOutput?
    
    init(photoAPI: PhotosAPI, album: AlbumResponseModel) {
        self.photoAPI = photoAPI
        self.album = album
    }
    
    func viewDidLoad() {
        guard let album = album else { return }
        retrievePhotoList(for: album)
    }
    
    func retrievePhotoList(for album: AlbumResponseModel) {
        LoadingManager.shared.show()
        photoAPI.retrieveAlbum(request: .init(albumId: album.id!)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let photoList):
                self.photoList.append(contentsOf: photoList)
                self.output!.home(self, photoListDidLoad: photoList)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
}
