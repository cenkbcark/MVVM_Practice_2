//
//  AlbumDetailViewModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import Foundation

protocol AlbumDetailViewModelInput {
    var output: AlbumDetailViewModelOutput? { get set }
    var user: UserResponseModel? { get set }
    func viewDidLoad()
    func retriveAlbumList(for user: UserResponseModel)
}

protocol AlbumDetailViewModelOutput: AnyObject {
    func home(_ viewModel: AlbumDetailViewModelInput, albumListDidLoad list: [AlbumResponseModel])
}

final class AlbumDetailViewModel: AlbumDetailViewModelInput {
    
    var albumList: [AlbumResponseModel] = []
    private let albumAPI: AlbumFetchable
    var user: UserResponseModel?
    var output: AlbumDetailViewModelOutput?
    
    init(albumAPI: AlbumAPI,user: UserResponseModel) {
        self.albumAPI = albumAPI
        self.user = user
    }
    
    func viewDidLoad() {
        guard let user = user else { return }
        retriveAlbumList(for: user)
    }
    
    func retriveAlbumList(for user: UserResponseModel) {
        LoadingManager.shared.show()
        albumAPI.retriveAlbum(request: .init(userId: user.id!)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let albumList):
                self.albumList.append(contentsOf: albumList)
                self.output!.home(self, albumListDidLoad: albumList)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
}
