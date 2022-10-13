//
//  UserRequestModel.swift
//  MVVM_Practice
//
//  Created by Cenk Bahadır Çark on 7.10.2022.
//

import Foundation

final class UserRequestModel: RequestModel{
    
    override init () { }
    
    override var path: String{
        Constant.API.users
    }
    
    override var method: RequestMethod{
        .get
    }
    
}
