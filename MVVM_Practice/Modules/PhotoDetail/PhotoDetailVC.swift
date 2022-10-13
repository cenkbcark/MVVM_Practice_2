//
//  PhotoDetailVC.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import UIKit

final class PhotoDetailVC: UIViewController {
    
    private var viewModel: PhotoDetailViewModelInput
    private var photoList: [PhotosResponseModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(viewModel: PhotoDetailViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "PhotoDetailVC", bundle: .main)
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCells() {
        let cellIdentifier = String(describing: PhotoDetailCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    private func setTitle() {
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
extension PhotoDetailVC: PhotoDetailViewModelOutput {
    func home(_ viewModel: PhotoDetailViewModelInput, photoListDidLoad list: [PhotosResponseModel]) {
        
        photoList = list
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension PhotoDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoDetailCell", for: indexPath) as? PhotoDetailCell {
            cell.setPhoto(for: photoList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
