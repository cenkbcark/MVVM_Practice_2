//
//  CustomCell.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 13.10.2022.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak private var mailLbl: UILabel!
    @IBOutlet weak private var nameLbl: UILabel!
    
    func setUser(from user: UserResponseModel){
        mailLbl.text = user.email
        nameLbl.text = user.name
    }
    
}
