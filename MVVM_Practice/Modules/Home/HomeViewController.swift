//
//  HomeViewController.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: HomeViewModelInput
    private var userList: [UserResponseModel] = []
    
    init(viewModel: HomeViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: .main)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        viewModel.viewDidLoad()
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        let cellIdentifier = String(describing: CustomCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func setTitle() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension HomeViewController: HomeViewModelOutput {
    
    func home(_ viewModel: HomeViewModelInput, userListDidLoad list: [UserResponseModel]) {
        userList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
            cell.setUser(from: userList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let albumApi = AlbumAPI(networkManager: networkManager)
        let albumDetailViewModel = AlbumDetailViewModel(albumAPI: albumApi, user: userList[indexPath.row])

        let albumDetailVC = AlbumDetailVC(viewModel: albumDetailViewModel)
        self.navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}

