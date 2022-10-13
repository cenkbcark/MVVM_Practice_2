//
//  HomeViewModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 12.10.2022.
//

import Foundation

protocol HomeViewModelInput {
    var output: HomeViewModelOutput? { get set }
    
    func viewDidLoad()
    func retriveUserList()
}

protocol HomeViewModelOutput: AnyObject {
    func home(_ viewModel: HomeViewModelInput, userListDidLoad list: [UserResponseModel])
}

final class HomeViewModel: HomeViewModelInput {
    
    var userList: [UserResponseModel] = []
    
    private let userAPI: UserFetchable
    var output: HomeViewModelOutput?
    
    init(userAPI: UserAPI) {
        self.userAPI = userAPI
    }
    
    func viewDidLoad() {
        retriveUserList()
    }
    
    func retriveUserList() {
        LoadingManager.shared.show()
        userAPI.retriveUser(request: .init()) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let userList):
                self.userList.append(contentsOf: userList)
                self.output?.home(self, userListDidLoad: userList)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
}
