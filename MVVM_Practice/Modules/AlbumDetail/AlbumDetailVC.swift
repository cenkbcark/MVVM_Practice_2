//
//  AlbumDetailVC.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import UIKit

final class AlbumDetailVC: UIViewController {
    
    private var viewModel: AlbumDetailViewModelInput
    private var albumList: [AlbumResponseModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: AlbumDetailViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "AlbumDetailVC", bundle: .main)
        self.viewModel.output = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self

    }
    func registerCells() {
        let cellIdentifier = String(describing: AlbumsDetailCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
extension AlbumDetailVC: AlbumDetailViewModelOutput {
    func home(_ viewModel: AlbumDetailViewModelInput, albumListDidLoad list: [AlbumResponseModel]) {
        
        albumList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
extension AlbumDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsDetailCell", for: indexPath) as? AlbumsDetailCell {
            cell.setAlbum(for: albumList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let photoApi = PhotosAPI(networkManager: networkManager)
        let photoDetailViewModel = PhotoDetailViewModel(photoAPI: photoApi, album: albumList[indexPath.row])
        
        let photoDetailVC = PhotoDetailVC(viewModel: photoDetailViewModel)
        self.navigationController?.pushViewController(photoDetailVC, animated: true)
        
    }
}
