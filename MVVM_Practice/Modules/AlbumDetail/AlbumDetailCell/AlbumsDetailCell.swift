//
//  AlbumsDetailCell.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import UIKit

final class AlbumsDetailCell: UITableViewCell {

    @IBOutlet weak private var albumTitleLbl: UILabel!
    
    func setAlbum(for album: AlbumResponseModel){
        albumTitleLbl.text = album.title
    }
}
